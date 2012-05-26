package com.bst.product.plugin.elt;

import java.util.HashMap;
import java.util.Map;

import org.jsoup.nodes.Document;

import com.bst.pro.util.BasicHttpClient;

public class ELTTest extends BasicHttpClient {

	public static void main(String[] args) {

		//step1
		//start page to get __EVENTVALIDATION and __VIEWSTATE
		//http://e1.englishtown.com/partner/coolschool/
		String startPageUrl = "http://e1.englishtown.com/partner/coolschool/";
		Document doc = getText(startPageUrl);
		
		String __EVENTVALIDATION = doc.select("#__EVENTVALIDATION").attr("value");
		String __VIEWSTATE = doc.select("#__VIEWSTATE").attr("value");
		
		//login page
		//https://securecn.englishtown.com/login/handler.ashx
		//Post Data
			//__EVENTVALIDATION	/wEWEwKK2aqiDAKlnuagAgKknragAgKnnsKgAgLOno6gAgLOnr6gAgLTnr6gAgKlnoqgAgLZno6gAgLYnvKgAgLQnoKgAgKjnp6gAgLWnuqgAgKjnoqgAgLbnvqgAgLUnpKgAgLSnp6gAgLSnragAgLdnt6/AmUd+1s+U7tdEFffp53p17o=	208	
			//__VIEWSTATE	/wEPDwUKLTM2OTM2NzQ0OA9kFgJmD2QWAgIBD2QWAgIBDxUCEy9wYXJ0bmVyL3N0eWxlLmFzaHgYfi9fc3R5bGVzL3NtYXJ0bG9naW4uY3NzZGTZ3zazUmapBQNIfvw7rUf+	148	
			//ctl00$ETFooter$LanguageBar1$ddlCountries	cs	49	
			//onsuccess		10	
			//Password	20101206	17	
			//pt	Cool	7	
			//referer	http://e1.englishtown.com/partner/coolschool/Default.aspx	77	
			//UserName	nli4700	16	
		//Cookie info
			//ctr	Sent	cn_sh	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//EFID	Sent	E960F758-3FA5-4109-BAB5-4F6A6412AA51	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//et_ctxtsoc	Sent	ver=1|~~	/	.englishtown.com	(Session)	Server	No	No
			//etctxtsess	Sent	ver=1.5|AEMAbwBvAGwAfgAtADEAfgBVAH4A	/	.englishtown.com	(Session)	Server	No	No
			//lng	Sent	cs	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//srperc	Sent	8	/	.englishtown.com	(Session)	Server	No	No
			//VMsi	Sent	593722786	/	.englishtown.com	(Session)	Server	No	No
		String loginUrl = "https://securecn.englishtown.com/login/handler.ashx";
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("__EVENTVALIDATION", __EVENTVALIDATION);//49
		data.put("__VIEWSTATE", __VIEWSTATE);//49
		data.put("ctl00$ETFooter$LanguageBar1$ddlCountries", "cs");//49
		data.put("onsuccess", "");//10
		data.put("Password", "20101206");//17
		data.put("pt", "Cool");//7
		data.put("referer", "http://e1.englishtown.com/partner/coolschool/Default.aspx");//77
		data.put("UserName", "nli4700");//16
		String jsData = postText(loginUrl, data);
		
		//get app info
		//{"d":{"__type":"LoadStudentBookingCardResult:EFSchools.Englishtown.Oboe.Client.Result","Success":true,"ErrorCode":"","BookingCardClassList":[{"__type":"BookingCardClassInfo:EFSchools.Englishtown.Oboe.Client.Booking","ScheduledClass_id":3051523,"City":"Shanghai","School":"SH Shinmay Union Square","ClassCategory_id":3,"ClassRoomName":"Integrity","ClassTopicName":"","ClassDate":"2012-05-30 12:40:00","StartTimePeriod":"20:40-21:30","BookingStatus":1,"NextStatus":4,"ClassType":"English Corner High","LevelCode":"0A","RankOfWait":0,"RankOfStandby":0,"FriendCapacity":0,"InvitedFriendsCount":0,"SeatLeft":8,"School_id":39,"TopicNameChinese":null,"AddressChinese":null},{"__type":"BookingCardClassInfo:EFSchools.Englishtown.Oboe.Client.Booking","ScheduledClass_id":3057594,"City":"Shanghai","School":"SH Shinmay Union Square","ClassCategory_id":2,"ClassRoomName":"Grace","ClassTopicName":"Experiences - Talking about experiences","ClassDate":"2012-05-30 11:40:00","StartTimePeriod":"19:40-20:30","BookingStatus":1,"NextStatus":4,"ClassType":"Intermediate A","LevelCode":"0A","RankOfWait":0,"RankOfStandby":0,"FriendCapacity":0,"InvitedFriendsCount":0,"SeatLeft":0,"School_id":39,"TopicNameChinese":null,"AddressChinese":null},{"__type":"BookingCardClassInfo:EFSchools.Englishtown.Oboe.Client.Booking","ScheduledClass_id":3051466,"City":"Shanghai","School":"SH Shinmay Union Square","ClassCategory_id":2,"ClassRoomName":"Grace","ClassTopicName":"Let's make a deal - Getting a good price","ClassDate":"2012-05-28 10:40:00","StartTimePeriod":"18:40-19:30","BookingStatus":1,"NextStatus":4,"ClassType":"Intermediate B","LevelCode":"0A","RankOfWait":0,"RankOfStandby":0,"FriendCapacity":0,"InvitedFriendsCount":0,"SeatLeft":7,"School_id":39,"TopicNameChinese":null,"AddressChinese":null}],"Paging":{"__type":"PagingResult:EFSchools.Englishtown.Oboe.Client.Result","PageSize":15,"PageIndex":1,"PageCount":1}}}
		//http://e1.englishtown.com/services/oboe2/1.0/bookingjsonservice.svc/LoadStudentBookingCard
		//POST data
			//{"loadParams":{"Member_id":19647339,"BeginDate":"2012-05-25 16:00:00","EndDate":"2012-06-17 16:00:00","LevelCode":"6","Token":"1d5cb76fb371c72902877ede781678b8","UtcDate":"2012-05-26 12:05:40","PartnerCode":"Cool","Paging":{"PageIndex":"1","PageSize":"15"}}}
		//Cookie Info
			//BigIPCT2	Received	e8D9+VsUdaFjRMVonxWhRC2+QPgNj7K/fEEt4IyymwQ/Igok9l8Ko9nYi9LPUdfvjaWldNeEaKynhj8=	/	e1.englishtown.com	(Session)	Server	No	No
			//bhCookieSess	Sent	1	/	e1.englishtown.com	(Session)	Server	No	No
			//bhResults	Sent	bhfx=11.2 r202&bhfv=2&bhpb=1	/	e1.englishtown.com	(Session)	JavaScript	No	No
			//BigIPCT	Sent	0p42JRQY3Iwsk29onxWhRC2+QPgNj5WWtw23ynQ9VR5/kUYcYtwkmgHd7xCyCGpmeNLy8DPDjx9aRw==	/	e1.englishtown.com	(Session)	Server	No	No
			//BigIPCT2	Sent	OV6G4ZAmAdoCDydonxWhRC2+QPgNj7UTQmKPrwoed8vGUMz27n4Gv8ESohkXZOFHjwTEHSkuwZjDGkM=	/	e1.englishtown.com	(Session)	Server	No	No
			//BIGipServerchat.englishtown.com_80	Sent	2269161664.20480.0000	/	e1.englishtown.com	(Session)	Server	No	No
			//CmtyState	Sent	ver=3|19647339~False~0~True~True~False~Nick~ONLINE~~1~~~$-1$$False$UN$False#False#False#False#False~True$True$False$True$False~Cool$NING$LI$$~~~cn~~m~	/	.englishtown.com	(Session)	Server	Yes	No
			//CMus	Sent	ADEAOQA2ADQANwAzADMAOQB8ADEAMwAzADgAMAAzADMAOQAwADcANAA2ADUAfABOAEwASQA0ADcAMAAwAHwATQB8AFMA	/	.e1.englishtown.com	(Session)	Server	No	No
			//ctr	Sent	cn_sh	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//divisionCode	Sent	SSCNSH10	/	.englishtown.com	(Session)	Server	No	No
			//dontshoworientationanymore	Sent	true	/	e1.englishtown.com	Thu, 26-May-2022 12:05:11 GMT	Server	No	No
			//EFID	Sent	E960F758-3FA5-4109-BAB5-4F6A6412AA51	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//et.toolbar	Sent	19647339|0|0|0|0|0|1	/	e1.englishtown.com	(Session)	JavaScript	No	No
			//et_ctxtsoc	Sent	ver=1|0~~	/	.englishtown.com	(Session)	Server	No	No
			//et_ds	Sent	us1	/	.e1.englishtown.com	(Session)	Server	No	No
			//et_sid	Sent	11ed3f99d4c647d3a104b94917315def	/	.e1.englishtown.com	(Session)	Server	No	No
			//etcomet_seq_19647339	Sent	1	/	e1.englishtown.com	(Session)	JavaScript	No	No
			//etctxtsess	Sent	ver=1.5|AEMAbwBvAGwAfgAxADkANgA0ADcAMwAzADkAfgBNAH4AYwBzA	/	.englishtown.com	(Session)	Server	No	No
			//imchat	Sent	{"uid":"19647339","ifi":1}	/	e1.englishtown.com	(Session)	JavaScript	No	No
			//IsSGC	Sent	true	/	.englishtown.com	(Session)	Server	No	No
			//lng	Sent	cs	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//MyPageThemeSettings	Sent	Theme=Default&Settings=Frame_LeftPanel=MyCourseViewNew|1,LiveTeacherBox|1,FeedBackBox|1&Frame_RightPanel=StageBox|1,TourBox|0,TranslatorBox|0&&ThemeMemberID=19647339&dontshoworientationanymore=true	/	e1.englishtown.com	Thu, 26-May-2022 12:05:11 GMT	Server	No	No
			//PartnerSite	Sent	Cool	/	e1.englishtown.com	(Session)	Server	No	No
			//srperc	Sent	8	/	.englishtown.com	(Session)	Server	No	No
			//techcheck_checked	Sent	1	/	e1.englishtown.com	Sat, 26 May 2012 12:10:19 GMT	JavaScript	No	No
			//techcheck_fcount	Sent	2	/	e1.englishtown.com	Sun, 26 May 2013 12:05:33 GMT	JavaScript	No	No
			//Translator3_User_Preference	Sent	False~False~False~zh-CN	/	e1.englishtown.com	(Session)	Server	No	No
			//VMsi	Sent	593722786	/	.englishtown.com	(Session)	Server	No	No
		
		
		//logout
		//http://e1.englishtown.com/master/welcome/members/logout.asp
		//Cookie Info
			//ASPSESSIONIDSCTRCACA	Received	ADBBBPNDKAAONGGHHGBIEGOC	/	e1.englishtown.com	(Session)	Server	No	No
			//CMus	Received		/	.e1.englishtown.com	(Session)	Server	No	No
			//commercecookie	Received		/	.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//commercecookie2	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//commercecookie2	Received		/	.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//CRCCookieName	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//ctr	Received	cn_sh	/	.englishtown.com	Sun, 01-Jun-2031 04:00:00 GMT	Server	No	No
			//EFID	Received	E960F758-3FA5-4109-BAB5-4F6A6412AA51	/	.englishtown.com	Sun, 01-Jun-2031 04:00:00 GMT	Server	No	No
			//et_school	Received		/	.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//et_school	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//et_school4	Received		/	.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//et_school4	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//et_smart_school2	Received		/	.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//et_smart_school2	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//ETownChatInfo	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//ETownChatUsers	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//imchat	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//IsSGC	Received	true	/	.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//lng	Received	cs	/	.englishtown.com	Sun, 01-Jun-2031 04:00:00 GMT	Server	No	No
			//MyPage_IsFirst	Received		/	e1.englishtown.com	(Session)	Server	No	No
			//MyPageThemeSettings	Received		/	.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//MyPageThemeSettings	Received		/	e1.englishtown.com	Tue, 01-Jan-1991 05:00:00 GMT	Server	No	No
			//newvmsi	Received	true	/	e1.englishtown.com	(Session)	Server	No	No
			//srd	Received	0	/	e1.englishtown.com	(Session)	Server	No	No
			//VMsi	Received		/	.englishtown.com	(Session)	Server	No	No
			//bhCookieSess	Sent	1	/	e1.englishtown.com	(Session)	Server	No	No
			//bhResults	Sent	bhfx=11.2 r202&bhfv=2&bhpb=1	/	e1.englishtown.com	(Session)	JavaScript	No	No
			//BigIPCT	Sent	0p42JRQY3Iwsk29onxWhRC2+QPgNj5WWtw23ynQ9VR5/kUYcYtwkmgHd7xCyCGpmeNLy8DPDjx9aRw==	/	e1.englishtown.com	(Session)	Server	No	No
			//BigIPCT2	Sent	aQrz9X6mjHg8fhJonxWhRC2+QPgNj9Hojd9fhURTqE2WJ9PAn52Uim1e5nEI1NRS76oOkStDa7VKi7w=	/	e1.englishtown.com	(Session)	Server	No	No
			//BIGipServerchat.englishtown.com_80	Sent	2269161664.20480.0000	/	e1.englishtown.com	(Session)	Server	No	No
			//CmtyState	Sent	ver=3|19647339~False~0~True~True~False~Nick~ONLINE~~1~~~$-1$$False$UN$False#False#False#False#False~True$True$False$True$False~Cool$NING$LI$$~~cn~~~m~	/	.englishtown.com	(Session)	Server	Yes	No
			//CMus	Sent	ADEAOQA2ADQANwAzADMAOQB8ADEAMwAzADgAMAAzADMAOQAwADcANAA2ADUAfABOAEwASQA0ADcAMAAwAHwATQB8AFMA	/	.e1.englishtown.com	(Session)	Server	No	No
			//ctr	Sent	cn_sh	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//divisionCode	Sent	SSCNSH10	/	.englishtown.com	(Session)	Server	No	No
			//dontshoworientationanymore	Sent	true	/	e1.englishtown.com	Thu, 26-May-2022 12:05:11 GMT	Server	No	No
			//EFID	Sent	E960F758-3FA5-4109-BAB5-4F6A6412AA51	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//et.toolbar	Sent	19647339|0|0|0|0|0|1	/	e1.englishtown.com	(Session)	JavaScript	No	No
			//et_ctxtsoc	Sent	ver=1|0~~	/	.englishtown.com	(Session)	Server	No	No
			//et_ds	Sent	us1	/	.e1.englishtown.com	(Session)	Server	No	No
			//et_sid	Sent	11ed3f99d4c647d3a104b94917315def	/	.e1.englishtown.com	(Session)	Server	No	No
			//etcomet_seq_19647339	Sent	1	/	e1.englishtown.com	(Session)	JavaScript	No	No
			//etctxtsess	Sent	ver=1.5|AEMAbwBvAGwAfgAxADkANgA0ADcAMwAzADkAfgBNAH4AYwBzA	/	.englishtown.com	(Session)	Server	No	No
			//imchat	Sent	{"uid":"19647339","ifi":1}	/	e1.englishtown.com	(Session)	JavaScript	No	No
			//IsSGC	Sent	true	/	.englishtown.com	(Session)	Server	No	No
			//lng	Sent	cs	/	.englishtown.com	Fri, 20-Feb-2015 13:04:43 GMT	Server	No	No
			//MyPageThemeSettings	Sent	Theme=Default&Settings=Frame_LeftPanel=MyCourseViewNew|1,LiveTeacherBox|1,FeedBackBox|1&Frame_RightPanel=StageBox|1,TourBox|0,TranslatorBox|0&&ThemeMemberID=19647339&dontshoworientationanymore=true	/	e1.englishtown.com	Thu, 26-May-2022 12:05:11 GMT	Server	No	No
			//PartnerSite	Sent	Cool	/	e1.englishtown.com	(Session)	Server	No	No
			//srperc	Sent	8	/	.englishtown.com	(Session)	Server	No	No
			//techcheck_checked	Sent	1	/	e1.englishtown.com	Sat, 26 May 2012 12:10:19 GMT	JavaScript	No	No
			//techcheck_fcount	Sent	2	/	e1.englishtown.com	Sun, 26 May 2013 12:05:33 GMT	JavaScript	No	No
			//Translator3_User_Preference	Sent	False~False~False~zh-CN	/	e1.englishtown.com	(Session)	Server	No	No
			//VMsi	Sent	593722786	/	.englishtown.com	(Session)	Server	No	No
	}
}
