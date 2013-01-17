package com.sobey.cmop.mvc.web.account;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sobey.cmop.mvc.entity.Group;
import com.sobey.cmop.mvc.entity.Permission;
import com.sobey.cmop.mvc.service.account.AccountManager;

@Controller
@RequestMapping(value = "/account/group")
public class GroupController {

	private static final int DEFAULT_PAGE_NUM = 0;
	private static final int DEFAULT_PAGE_SIZE = 8;
	private static final String REDIRECT_SUCCESS_URL = "redirect:/account/group/";

	@Autowired
	private AccountManager accountManager;

	@RequestMapping(value = {"list", ""})
	public String list(@RequestParam(value = "page", required = false) Integer page, Model model) {
		int pageNum = page != null ? page : DEFAULT_PAGE_NUM;
		Page<Group> groups = accountManager.getAllGroup(pageNum, DEFAULT_PAGE_SIZE);
		model.addAttribute("page", groups);
		return "account/groupList";
	}

	@RequestMapping(value = "/save", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("group", new Group());
		model.addAttribute("allPermissions", Permission.values());
		return "account/groupForm";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Group group, RedirectAttributes redirectAttributes) {
		accountManager.saveGroup(group);
		redirectAttributes.addFlashAttribute("message", "创建权限组 " + group.getName() + " 成功");
		return REDIRECT_SUCCESS_URL;
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("allPermissions", Permission.values());
		model.addAttribute("group", accountManager.getGroup(id));
		return "account/groupForm";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute("group") Group group, RedirectAttributes redirectAttributes) {
		accountManager.saveGroup(group);
		redirectAttributes.addFlashAttribute("message", "修改权限组 " + group.getName() + " 成功");
		return REDIRECT_SUCCESS_URL;
	}

	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {

		boolean falg = accountManager.deleteGroup(id);
		if (!falg) {
			redirectAttributes.addFlashAttribute("message", "不能删除默认权限组!");
		} else {
			redirectAttributes.addFlashAttribute("message", "删除权限组成功");
		}
		return REDIRECT_SUCCESS_URL;
	}

	@RequestMapping(value = "checkGroupName")
	public @ResponseBody
	String checkGroupName(@RequestParam("oldName") String oldName, @RequestParam("name") String name) {
		if (name.equals(oldName) || accountManager.findGroupByName(name) == null) {
			return "true";
		}
		return "false";
	}

}
