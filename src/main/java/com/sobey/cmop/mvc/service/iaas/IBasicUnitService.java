package com.sobey.cmop.mvc.service.iaas;

import java.util.List;

import com.sobey.cmop.mvc.entity.ComputeItem;
import com.sobey.cmop.mvc.entity.MonitorCompute;
import com.sobey.cmop.mvc.entity.MonitorElb;
import com.sobey.cmop.mvc.entity.NetworkDnsItem;
import com.sobey.cmop.mvc.entity.NetworkEipItem;
import com.sobey.cmop.mvc.entity.NetworkElbItem;
import com.sobey.cmop.mvc.entity.StorageItem;

/**
 * 根据资源Resources对象Id获得指定用户的所有基础设施的信息并对其进行对象封装.
 * 
 * 本质上就是查出审批通过的各个Iaas的List,dao查询出来的是无泛型的List,将其封装成 Iass对象 List,已方便后续的操作. 注意表中的字段顺序!!!
 * 
 * @author liukai
 * 
 */
public interface IBasicUnitService {

	/**
	 * 获得elb下所有关联的实例
	 * 
	 * @param elbId
	 * @return
	 */
	public List<ComputeItem> getComputeListByElb(Integer elbId);

	// ======== Iaas ========

	/**
	 * Compute
	 * 
	 * @param userId
	 * @return
	 */
	public List<ComputeItem> getComputeItemListByResources(Integer userId);

	/**
	 * StorageItem
	 * 
	 * @param userId
	 * @return
	 */
	public List<StorageItem> getStorageItemListByResources(Integer userId);

	/**
	 * NetworkElbItem
	 * 
	 * @param userId
	 * @return
	 */
	public List<NetworkElbItem> getNetworkElbItemListByResources(Integer userId);

	/**
	 * NetworkEipItem
	 * 
	 * @param userId
	 * @return
	 */
	public List<NetworkEipItem> getNetworkEipItemListByResources(Integer userId);

	/**
	 * NetworkDnsItem
	 * 
	 * @param userId
	 * @return
	 */
	public List<NetworkDnsItem> getNetworkDnsItemListByResources(Integer userId);

	/**
	 * MonitorCompute
	 * 
	 * @param userId
	 * @return
	 */
	public List<MonitorCompute> getMonitorComputeListByResources(Integer userId);

	/**
	 * MonitorElb
	 * 
	 * @param userId
	 * @return
	 */
	public List<MonitorElb> getMonitorElbListByResources(Integer userId);

	/**
	 * 将SQL查询出的对象,封装成ComputeItem.
	 * 
	 * @param object
	 * @return
	 */
	ComputeItem wrapComputeItem(Object[] object);

}
