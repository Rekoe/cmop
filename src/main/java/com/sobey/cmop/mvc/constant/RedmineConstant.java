package com.sobey.cmop.mvc.constant;

import java.util.Map;

import com.google.common.collect.Maps;

/**
 * redmine 模块的常量
 * 
 * @author liukai
 * 
 */
public class RedmineConstant {

	/**
	 * 100% 完成度.
	 */
	public static final Integer MAX_DONERATIO = 100;

	/**
	 * Redmine中的指派人访问密匙apiAccessKey
	 */
	public static final Map<Integer, String> REDMINE_ASSIGNEE_KEY_MAP = Maps.newLinkedHashMap();
	static {
		REDMINE_ASSIGNEE_KEY_MAP.put(3, "7311814a8437bbb537ceecf0649896b0aab96770");
		REDMINE_ASSIGNEE_KEY_MAP.put(4, "3e99c32cf5cd65359f9fc2f6f0078a292435a50a");
		REDMINE_ASSIGNEE_KEY_MAP.put(5, "2719809bde13dab34780b5d79ab2be0632a6c78e");
		REDMINE_ASSIGNEE_KEY_MAP.put(6, "f62b1e861ea111df6fec363d56da86fe2ef0fe5b");
		REDMINE_ASSIGNEE_KEY_MAP.put(7, "7b14d51c40e4e3878d891b9a8a3d22f9143e13d1");
		REDMINE_ASSIGNEE_KEY_MAP.put(8, "de1674cda903aa0efc79c0a4476776a8dc20cd18");
		REDMINE_ASSIGNEE_KEY_MAP.put(9, "ac70b780ad9ebf458a5c746f063d53fbe927af30");
		REDMINE_ASSIGNEE_KEY_MAP.put(10, "4dab51f68b5987a2bcdcc505e59418805c4a4aa4");
	}

	/**
	 * Redmine中的完成比 0-100%
	 */
	public static final Map<Integer, String> REDMINE_DONERATIO_MAP = Maps.newLinkedHashMap();
	static {
		REDMINE_DONERATIO_MAP.put(0, "0%");
		REDMINE_DONERATIO_MAP.put(10, "10%");
		REDMINE_DONERATIO_MAP.put(20, "20%");
		REDMINE_DONERATIO_MAP.put(30, "30%");
		REDMINE_DONERATIO_MAP.put(40, "40%");
		REDMINE_DONERATIO_MAP.put(50, "50%");
		REDMINE_DONERATIO_MAP.put(60, "60%");
		REDMINE_DONERATIO_MAP.put(70, "70%");
		REDMINE_DONERATIO_MAP.put(80, "80%");
		REDMINE_DONERATIO_MAP.put(90, "90%");
		REDMINE_DONERATIO_MAP.put(100, "100%");
	}

	/**
	 * Redmine中的指派人
	 * 
	 * <pre>
	 * 4-朱少龙
	 * 5-艾磊
	 * 6-杨飞
	 * 7-胡光俊
	 * 8-李乾星
	 * 9-刘力铭
	 * </pre>
	 * 
	 * @author liukai
	 * 
	 */
	public enum Assignee implements ICommonEnum {

		陆俊(3), 朱少龙(4), 艾磊(5), 杨飞(6), 胡光俊(7), 李乾星(8), 苏颖(10);

		public static final Map<Integer, String> map = Maps.newLinkedHashMap();

		public static final Map<String, String> mapKeyStr = Maps.newLinkedHashMap();

		static {
			for (Assignee e : Assignee.values()) {

				map.put(e.code, e.name());

			}
		}
		static {
			for (Assignee e : Assignee.values()) {

				mapKeyStr.put(String.valueOf(e.code), e.name());

			}
		}

		public static String get(Integer code) {
			return map.get(code);
		}

		private int code;

		private Assignee(int code) {
			this.code = code;
		}

		@Override
		public Integer toInteger() {
			return this.code;
		}

		@Override
		public String toString() {
			return String.valueOf(this.code);
		}

	}

	/**
	 * redmine中的优先级(也用于服务申请单Apply中)
	 * 
	 * <pre>
	 * 4-普通
	 * 5-高
	 * 6-紧急
	 * </pre>
	 * 
	 * @author liukai
	 * 
	 */
	public enum Priority implements ICommonEnum {

		普通(4), 高(5), 紧急(6);

		public static final Map<Integer, String> map = Maps.newLinkedHashMap();

		// 用于在Freemarker上遍历(Freemarker中,HashMap的key只能为String类型.我草!)
		public static final Map<String, String> mapKeyStr = Maps.newLinkedHashMap();

		static {
			for (Priority e : Priority.values()) {

				map.put(e.code, e.name());

			}
		}
		static {
			for (Priority e : Priority.values()) {

				mapKeyStr.put(String.valueOf(e.code), e.name());

			}
		}

		public static String get(Integer code) {
			return map.get(code);
		}

		private int code;

		private Priority(int code) {
			this.code = code;
		}

		@Override
		public Integer toInteger() {
			return this.code;
		}

		@Override
		public String toString() {
			return String.valueOf(this.code);
		}

	}

	/**
	 * redmine_project
	 * 
	 * <pre>
	 * 1-SobeyCloud运营
	 * 2-Iaas
	 * 3-SobeyCloud问题库
	 * 4-Paas_Saas
	 * 5-Sobey Cloud设计
	 * </pre>
	 * 
	 * @author liukai
	 * 
	 */
	public enum Project implements ICommonEnum {

		SobeyCloud运营(1), Iaas(2), SobeyCloud问题库(3), Paas_Saas(4), SobeyCloud设计(5);

		public static final Map<Integer, String> map = Maps.newLinkedHashMap();

		public static final Map<String, String> mapKeyStr = Maps.newLinkedHashMap();

		static {
			for (Project e : Project.values()) {

				map.put(e.code, e.name());

			}
		}
		static {
			for (Project e : Project.values()) {

				mapKeyStr.put(String.valueOf(e.code), e.name());

			}
		}

		public static String get(Integer code) {
			return map.get(code);
		}

		private int code;

		private Project(int code) {
			this.code = code;
		}

		@Override
		public Integer toInteger() {
			return this.code;
		}

		@Override
		public String toString() {
			return String.valueOf(this.code);
		}

	}

	/**
	 * Redmine中的状态
	 * 
	 * <pre>
	 * 1-新建
	 * 2-处理中
	 * 5-关闭
	 * </pre>
	 * 
	 * @author liukai
	 * 
	 */
	public enum Status implements ICommonEnum {

		新建(1), 处理中(2), 关闭(5);

		public static final Map<Integer, String> map = Maps.newLinkedHashMap();

		// 用于在Freemarker上遍历(Freemarker中,HashMap的key只能为String类型.我草!)
		public static final Map<String, String> mapKeyStr = Maps.newLinkedHashMap();

		static {
			for (Status e : Status.values()) {

				map.put(e.code, e.name());

			}
		}
		static {
			for (Status e : Status.values()) {

				mapKeyStr.put(String.valueOf(e.code), e.name());

			}
		}

		public static String get(Integer code) {
			return map.get(code);
		}

		private int code;

		private Status(int code) {
			this.code = code;
		}

		@Override
		public Integer toInteger() {
			return this.code;
		}

		@Override
		public String toString() {
			return String.valueOf(this.code);
		}

	}

	/**
	 * redmine_tracker
	 * 
	 * <pre>
	 * 1-错误
	 * 2-功能
	 * 3-支持
	 * </pre>
	 * 
	 * @author liukai
	 * 
	 */
	public enum Tracker implements ICommonEnum {

		错误(1), 功能(2), 支持(3);

		public static final Map<Integer, String> map = Maps.newLinkedHashMap();

		public static final Map<String, String> mapKeyStr = Maps.newLinkedHashMap();

		static {
			for (Tracker e : Tracker.values()) {

				map.put(e.code, e.name());

			}
		}
		static {
			for (Tracker e : Tracker.values()) {

				mapKeyStr.put(String.valueOf(e.code), e.name());

			}
		}

		public static String get(Integer code) {
			return map.get(code);
		}

		private int code;

		private Tracker(int code) {
			this.code = code;
		}

		@Override
		public Integer toInteger() {
			return this.code;
		}

		@Override
		public String toString() {
			return String.valueOf(this.code);
		}

	}

}
