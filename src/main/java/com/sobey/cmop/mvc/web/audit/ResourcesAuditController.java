package com.sobey.cmop.mvc.web.audit;

import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sobey.cmop.mvc.comm.BaseController;
import com.sobey.cmop.mvc.constant.AccountConstant;
import com.sobey.cmop.mvc.constant.AuditConstant;
import com.sobey.cmop.mvc.entity.Audit;
import com.sobey.cmop.mvc.entity.AuditFlow;
import com.sobey.cmop.mvc.entity.ServiceTag;
import com.sobey.framework.utils.Servlets;

/**
 * ResourcesAuditController负责资源变更Resources审批的管理
 * 
 * @author liukai
 * 
 */
@Controller
@RequestMapping(value = "/audit")
public class ResourcesAuditController extends BaseController {

	private static final String REDIRECT_SUCCESS_URL = "redirect:/audit/resources/";

	/**
	 * 显示所有的serviceTag list
	 */
	@RequestMapping(value = "resources")
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize, Model model,
			ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, REQUEST_PREFIX);
		model.addAttribute("page", comm.auditService.getAuditResourcesPageable(searchParams, pageNumber, pageSize));
		// 将搜索条件编码成字符串,分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, REQUEST_PREFIX));
		return "audit/resource/auditResourcesList";
	}

	/**
	 * 邮件里面执行审批操作(服务标签serviceTag)
	 * 
	 * @param serviceTagId
	 *            服务标签ID
	 * @param userId
	 *            审批人ID
	 * @param result
	 *            审批结果
	 * @param opinion
	 *            审批意见
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "resources/auditOk")
	public String auditOk(@RequestParam(value = "serviceTagId") Integer serviceTagId,
			@RequestParam(value = "userId") Integer userId, @RequestParam(value = "result") String result,
			@RequestParam(value = "opinion", required = false, defaultValue = "") String opinion, Model model) {
		String message;
		if (comm.auditService.isAudited(comm.serviceTagService.getServiceTag(serviceTagId), userId)) { // 该服务申请已审批过.
			message = "你已审批";
		} else {
			// 获得指定serviceTag当前审批记录
			Audit audit = this.getCurrentResourcesAudit(userId, serviceTagId);
			audit.setResult(result);
			audit.setOpinion(opinion);
			boolean flag = comm.auditService.saveAuditToResources(audit, serviceTagId, userId);
			message = flag ? "审批操作成功" : "审批操作失败,请稍后重试";
		}
		model.addAttribute("message", message);
		return "audit/auditOk";
	}

	/**
	 * 跳转到Resources审批页面.
	 * 
	 * <pre>
	 *  通过userId来区分页面或邮件进入.
	 *  页面进来userId为0,这个时候取当前UserId.
	 *  邮件进来的UserId就不为0.
	 * </pre>
	 * 
	 * @param serviceTagId
	 *            服务标签ID
	 * @param userId
	 *            审批人ID
	 * @param result
	 *            审批结果
	 * @param view
	 *            审批列表进入的是1.为null表示从邮件进入的.
	 * @param auditId
	 *            auditId.
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/resources/{id}", method = RequestMethod.GET)
	public String resources(@PathVariable("id") Integer serviceTagId,
			@RequestParam(value = "userId", required = false, defaultValue = "0") Integer userId,
			@RequestParam(value = "result", required = false, defaultValue = "") String result,
			@RequestParam(value = "auditId", required = false, defaultValue = "0") Integer auditId,
			@RequestParam(value = "view", required = false) Integer view, Model model) {

		String returnUrl = "";
		ServiceTag serviceTag = comm.serviceTagService.getServiceTag(serviceTagId);

		if (view == null && comm.auditService.isAudited(serviceTag, userId)) { // 判断该服务申请已审批过.
			model.addAttribute("message", "你已审批");
			returnUrl = "audit/auditOk";
		} else {
			model.addAttribute("result", result);
			model.addAttribute("view", view);
			model.addAttribute("userId", AccountConstant.FROM_PAGE_USER_ID.equals(userId) ? getCurrentUserId() : userId);
			model.addAttribute("serviceTag", serviceTag);
			model.addAttribute("resourcesList",
					comm.resourcesService.getCommitedResourcesListByServiceTagId(serviceTagId));
			model.addAttribute("audits", comm.auditService.getAuditListByServiceTagId(serviceTagId));
			model.addAttribute("changes",
					comm.changeHistoryService.getChangeHistoryListByAudit(comm.auditService.getAudit(auditId)));
			returnUrl = "audit/resource/auditResourcesForm";
		}
		return returnUrl;
	}

	/**
	 * 审批
	 * 
	 * @param serviceTagId
	 *            服务标签ID
	 * @param userId
	 *            审批人Id
	 * @param result
	 *            审批结果
	 * @param opinion
	 *            审批内容
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/resources/{serviceTagId}", method = RequestMethod.POST)
	public String saveApply(@PathVariable(value = "serviceTagId") Integer serviceTagId,
			@RequestParam(value = "userId") Integer userId, @RequestParam(value = "result") String result,
			@RequestParam(value = "opinion", defaultValue = "") String opinion, RedirectAttributes redirectAttributes) {

		// 获得指定apply当前审批记录
		Audit audit = this.getCurrentResourcesAudit(userId, serviceTagId);
		audit.setOpinion(opinion);
		audit.setResult(result);

		boolean flag = comm.auditService.saveAuditToResources(audit, serviceTagId, userId);
		String message = flag ? "审批操作成功" : "审批操作失败,请稍后重试";
		redirectAttributes.addFlashAttribute("message", message);

		return REDIRECT_SUCCESS_URL;
	}

	/**
	 * 获得指定serviceTag当前审批记录
	 * 
	 * <pre>
	 * 根据serviceTagId,auditFlow获得状态为"待审批"的audit.
	 * 此audit为申请人或上级审批人进行操作时,插入下级审批人的audit中的临时数据.
	 * </pre>
	 * 
	 * @param userId
	 *            审批人Id
	 * @param serviceTagId
	 *            标签Id
	 * @return
	 */
	private Audit getCurrentResourcesAudit(Integer userId, Integer serviceTagId) {

		Integer flowType = AuditConstant.FlowType.资源申请_变更的审批流程.toInteger();
		AuditFlow auditFlow = comm.auditService.findAuditFlowByUserIdAndFlowType(userId, flowType);

		Integer status = AuditConstant.AuditStatus.待审批.toInteger();

		return comm.auditService.findAuditByServiceTagIdAndStatusAndAuditFlow(serviceTagId, status, auditFlow);
	}

}
