package uims.common.tools.app;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.http.client.CookieStore;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.params.CookiePolicy;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.log4j.Logger;

import uims.common.tools.util.BasicMultiThreadedHttpClient;

public class KDGen extends BasicMultiThreadedHttpClient {

	static Logger log = Logger.getLogger(KDGen.class.getName());

	static String num = "243489559219";
	private static String id;

	// create context
	static HttpContext localContext = new BasicHttpContext();
	// create cookie manager
	static CookieStore cookieStroe = new BasicCookieStore();

	public static void main(String[] args) {
		KDGen kdg = new KDGen();
		kdg.action();
	}

	private void action() {
		setLocalCookieManger();

		// 读取文件
		File idFile = new File("dh.txt");

		// System.out.println("current:" + num);

		// String sessionid = getQuerySid();

		String line;
		ArrayList<String> cLines = new ArrayList<String>();
		for (int i = 0; i < 1; i++) {
			while (true) {
				line = "id:[" + i + 1 + "]" + num;
				System.out.println(line);

				id = num;
				String nextNum = genCheckNum(id);
				if (queryStatue(null, nextNum)) {
					cLines.add(line);
					System.out.println("nextnum:" + nextNum);
					break;
				}

				num = nextNum;
			}

			// 写入文件

		}

		try {
			FileUtils.writeLines(idFile, cLines);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		shutdown();
	}

	protected static void setLocalCookieManger() {
		createMultiThreadedHttpClient();
		// bind cookie manager to context
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStroe);
		localContext.setAttribute(ClientPNames.COOKIE_POLICY,
				CookiePolicy.BROWSER_COMPATIBILITY);
	}

	private static boolean queryStatue(String sessionid, String nextNum) {

		boolean isOk = false;
		// getSesion

		String postid = nextNum;
		// http://baidu.kuaidi100.com/query?type=shunfeng&postid=243802161192&id=4&valicode=验证码&temp=0.29986335352940874&sessionid=3D60F4362676834A837A13FBE11D576F

		String queryStatuUrl = "http://baidu.kuaidi100.com/query?type=shunfeng&"
				+ "postid="
				+ postid // "243802161192" +
				+ "&id=4&valicode=%E9%AA%8C%E8%AF%81%E7%A0%81&temp=0.8096473298777745&sessionid=FCBF806F355F53868D7B4DE0BDD31DF9";
		// + "&"
		// + "id=4&"
		// + "valicode=%E9%AA%8C%E8%AF%81%E7%A0%81&"
		// + "temp=0.6442193262137477&"
		// + "sessionid=3D60F4362676834A837A13FBE11D576F";
		// + sessionid;//"32BA1874BCBA8B355E0F4C268C8EC59C"

		JSONObject retJson = getTextToJson(queryStatuUrl);
		if(retJson == null){
			return isOk;
		}
		if (retJson.getString("status").equals("200")) {
			JSONArray datas = retJson.getJSONArray("data");
			Iterator<JSONObject> datasI = datas.iterator();
			while (datasI.hasNext()) {
				JSONObject data = datasI.next();
				String ftime = data.getString("ftime");
				String context = data.getString("context");
				String dateStr = ftime.substring(0, 10);
				if ((dateStr.equals("2012-12-21")
						|| dateStr.equals("2012-12-22") || dateStr
							.equals("2012-12-23"))
						&& context.equals("已收件[上海市]")) {
					isOk = true;
					break;
				}
			}
		} else {
			System.out.println(retJson.toString());
		}
		// {
		// "nu": "243802161183",
		// "message": "ok",
		// "ischeck": "1",
		// "com": "shunfeng",
		// "updatetime": "2012-12-22 22:51:50",
		// "status": "200",
		// "condition": "F00",
		// "data": [
		// {
		// "time": "2012-12-21 09:54:55",
		// "context": "�ɼ���ǩ��[������]",
		// "ftime": "2012-12-21 09:54:55"
		// },
		// {
		// "time": "2012-12-21 09:54:00",
		// "context": "ǩ�����ǣ���[������]",
		// "ftime": "2012-12-21 09:54:00"
		// },
		// {
		// "time": "2012-12-21 08:20:44",
		// "context": "�����ɼ�..[������]",
		// "ftime": "2012-12-21 08:20:44"
		// },
		// {
		// "time": "2012-12-21 06:22:07",
		// "context": "����� ����ɢ����,׼��������һվ����[������]",
		// "ftime": "2012-12-21 06:22:07"
		// },
		// {
		// "time": "2012-12-21 00:23:27",
		// "context": "����� �Ϻ���ɢ����,׼��������һվ����ɢ����[�Ϻ���]",
		// "ftime": "2012-12-21 00:23:27"
		// },
		// {
		// "time": "2012-12-20 22:15:41",
		// "context": "����� �Ϻ�,׼��������һվ�Ϻ���ɢ����[�Ϻ���]",
		// "ftime": "2012-12-20 22:15:41"
		// },
		// {
		// "time": "2012-12-20 19:57:54",
		// "context": "���ռ�[�Ϻ���]",
		// "ftime": "2012-12-20 19:57:54"
		// }
		// ],
		// "state": "3"
		// }

		return isOk;
	}

	private static String getQuerySid() {
		// String getSessionidUrl =
		// "http://baidu.kuaidi100.com/js/page/frame/baidu/company.js?com=shunfeng&version=201210251646";
		// getText(getSessionidUrl);

		String jsAuthoUrl = "http://baidu.kuaidi100.com/baidu/order?method=isautho";
		postText(jsAuthoUrl);

		String sessionid = null;
		CookieStore cookieStroe = getCookieStroe();
		List<Cookie> cookies = cookieStroe.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("JSESSIONID")) {
				sessionid = cookie.getValue();
				log.debug("webim_sessionid:" + sessionid);
			}
		}

		return sessionid;
	}

	private static String genCheckNum(String num) {
		int[] nums = getNums(num);

		String nextNum = null;
		int checkNum = -1;

		if (nums[10] != 9) {
			checkNum = (nums[11] + 9) % 10;
		} else {
			if (nums[9] == 0 || nums[9] == 1 || nums[9] == 2 || nums[9] == 4
					|| nums[9] == 5 || nums[9] == 7 || nums[9] == 8) {
				checkNum = (nums[11] + 6) % 10;
			} else if (nums[9] == 3 || nums[9] == 6) {
				checkNum = (nums[11] + 5) % 10;
			} else {
				if (nums[8] == 0 || nums[8] == 2 || nums[8] == 4
						|| nums[8] == 6 || nums[8] == 8) {
					checkNum = (nums[11] + 3) % 10;
				} else if (nums[8] == 1 || nums[8] == 3 || nums[8] == 5
						|| nums[8] == 7) {
					checkNum = (nums[11] + 2) % 10;
				} else {
					if (nums[7] == 0 || nums[7] == 3 || nums[7] == 6) {
						checkNum = (nums[11] + 0) % 10;
					} else if (nums[7] == 1 || nums[7] == 2 || nums[7] == 4
							|| nums[7] == 5 || nums[7] == 7 || nums[7] == 8) {
						checkNum = (nums[11] + 9) % 10;
					} else {
						if (nums[6] == 0) {
							checkNum = (nums[11] + 7) % 10;
						} else if (nums[6] == 1 || nums[6] == 2 || nums[6] == 3
								|| nums[6] == 4 || nums[6] == 5 || nums[6] == 6
								|| nums[6] == 7 || nums[6] == 8) {
							checkNum = (nums[11] + 6) % 10;
						} else {
							if (nums[5] == 0 || nums[5] == 1 || nums[5] == 2
									|| nums[5] == 3 || nums[5] == 4
									|| nums[5] == 5 || nums[5] == 6
									|| nums[5] == 7 || nums[5] == 8) {
								checkNum = (nums[11] + 3) % 10;
							} else {
								if (nums[4] == 0 || nums[4] == 1
										|| nums[4] == 2 || nums[4] == 4
										|| nums[4] == 5 || nums[4] == 7
										|| nums[4] == 8) {
									checkNum = (nums[11] + 9) % 10;
								} else if (nums[4] == 3 || nums[4] == 6) {
									checkNum = (nums[11] + 8) % 10;
								} else {
									if (nums[3] == 0 || nums[3] == 2
											|| nums[3] == 4 || nums[3] == 6
											|| nums[3] == 8) {
										checkNum = (nums[11] + 5) % 10;
									} else if (nums[3] == 1 || nums[3] == 3
											|| nums[3] == 5 || nums[3] == 7) {
										checkNum = (nums[11] + 4) % 10;
									} else {

									}
								}
							}
						}
					}
				}
			}
		}
		if (checkNum != -1) {
			long current = Long.parseLong(num.substring(0, 11));
			current++;

			nextNum = Long.toString(current) + Integer.toString(checkNum);
		}

		return nextNum;
	}

	private static int[] getNums(String idPart12) {
		int[] nums = new int[12];
		if (idPart12 == null || idPart12.length() != 12) {
			nums = null;
		} else {
			for (int i = 0; i < 12; i++) {
				nums[i] = Integer.parseInt(idPart12.substring(i, i + 1));
			}
		}
		return nums;
	}
}
