package com.KoreaIT.sdy.demo.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.KoreaIT.sdy.demo.repository.ScheduleDao;
import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.Club;
import com.KoreaIT.sdy.demo.vo.DateData;
import com.KoreaIT.sdy.demo.vo.Rq;
import com.KoreaIT.sdy.demo.vo.ScheduleDto;

@Controller
public class UsrCalenderController {
	@Autowired
	SqlSession sqlsession;
	
	@Autowired
	ScheduleDao scheduleDao;
	
	@Autowired
	ClubService clubService;
	
	@Autowired
	Rq rq;

	@RequestMapping(value = "/usr/calendar/do", method = RequestMethod.GET)
	public String calendar(Model model, HttpServletRequest request, DateData dateData, @RequestParam(defaultValue = "0") int clubId) {
		
		if(rq.getLoginedMemberId()==0) {
			return rq.jsHistoryBackOnView("F-1", "로그인 후 이용해주세요.");
		}

		Calendar cal = Calendar.getInstance();
		DateData calendarData;
		// 검색 날짜
		if (dateData.getDate().equals("") && dateData.getMonth().equals("")) {
			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)), String.valueOf(cal.get(Calendar.MONTH)),
					String.valueOf(cal.get(Calendar.DATE)), null, null);
		}

		Map<String, Integer> today_info = dateData.today_info(dateData);
		List<DateData> dateList = new ArrayList<DateData>();


		// 검색 날짜 end
		ScheduleDao scheduleDao = sqlsession.getMapper(ScheduleDao.class);
		
		ArrayList<ScheduleDto> Schedule_list = scheduleDao.schedule_list(dateData);

		// 달력 데이터에 넣기 위한 배열 추가
		ArrayList<List<ScheduleDto>> schedule_data_arr = new ArrayList<>();
		for (int i = 0; i < 32; i++) {
			schedule_data_arr.add(new ArrayList<>());
		}

		// 이전에 스케줄 추가한 데이터 DB에서 가져오기
		if (!Schedule_list.isEmpty()) {
			int j = 0;
			for (int i = 0; i < Schedule_list.size(); i++) {
				int startdate = Integer.parseInt(String.valueOf(Schedule_list.get(i).getSchedule_startdate())
						.substring(String.valueOf(Schedule_list.get(i).getSchedule_startdate()).length() - 2));
				int enddate = Integer.parseInt(String.valueOf(Schedule_list.get(i).getSchedule_enddate())
						.substring(String.valueOf(Schedule_list.get(i).getSchedule_enddate()).length() - 2));
				for (int date = startdate; date <= enddate; date++) {
					if (i > 0) {
						int date_before = Integer
								.parseInt(String.valueOf(Schedule_list.get(i - 1).getSchedule_startdate()).substring(
										String.valueOf(Schedule_list.get(i - 1).getSchedule_startdate()).length() - 2));
						if (date_before == date) {
							j = j + 1;
							schedule_data_arr.get(date).add(Schedule_list.get(i));
						} else {
							j = 0;
							schedule_data_arr.get(date).add(Schedule_list.get(i));
						}
					} else {
						schedule_data_arr.get(date).add(Schedule_list.get(i));
					}
				}
				ScheduleDto schedule = Schedule_list.get(i);
			}
		}

		// 실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		// 일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		//재 월의 첫 번째 요일까지 빈 데이터를 dateList에 추가
		for (int i = 1; i < today_info.get("start"); i++) {
			calendarData = new DateData(null, null, null, null, null);
			dateList.add(calendarData);
		}

		// 날짜 삽입
		// 현재 월의 날짜 데이터를 dateList에 추가
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			List<ScheduleDto> schedule_data_arr3 = schedule_data_arr.get(i);

			if (i == today_info.get("today")) {
				calendarData = new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()),
						String.valueOf(i), "today", schedule_data_arr3.toArray(new ScheduleDto[0]));
			} else {
				calendarData = new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()),
						String.valueOf(i), "normal_date", schedule_data_arr3.toArray(new ScheduleDto[0]));
			}
			dateList.add(calendarData);
		}

		// 빈 데이터 삽입
		int index = 7 - dateList.size() % 7;
		if (dateList.size() % 7 != 0) {
			for (int i = 0; i < index; i++) {
				calendarData = new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()),
						null, "normal_date", null);
				dateList.add(calendarData);
			}
		}
		
		Club club = clubService.getClubById(clubId);

		// 배열에 담음
		model.addAttribute("dateList", dateList); // 날짜 데이터 배열
		model.addAttribute("today_info", today_info);
		model.addAttribute("club", club);
		return "usr/calender/calender";
	}



	@RequestMapping(value = "usr/calendar/add", method = RequestMethod.GET)
	public String schedule_add(HttpServletRequest request, ScheduleDto scheduleDto, RedirectAttributes rttr) {
		ScheduleDao scheduleRepository = sqlsession.getMapper(ScheduleDao.class);
		
		String message = "";
		
		
		String url = "";
		
		if(scheduleDto.getClubId()==0) {
			url = "redirect:../calendar/do";
		}
		else {
			url = "redirect:../calendar/do?clubId=" + scheduleDto.getClubId();
		}

		scheduleRepository.schedule_add(scheduleDto);
		message = "스케쥴이 등록되었습니다";

		rttr.addFlashAttribute("message", message);
		return url;
	}

	@RequestMapping("/usr/calender/delete")
	@ResponseBody
	public String doDelete(int idx) {

		ScheduleDto schedule = scheduleDao.getSchedule(idx);

		if (schedule == null) {
			return Ut.jsHistoryBack("F-D", "존재하지 않는 일정입니다");
		}

		scheduleDao.deleteSchedule(idx);

		return Ut.jsReplace("S-1", "삭제완료", "../calendar/do");

	}
	@RequestMapping("/usr/calender/edit")
	@ResponseBody
	public String doEdit(int schedule_idx, String schedule_subject, String schedule_desc, Date schedule_startdate, Date schedule_enddate) {
		
		ScheduleDto schedule = scheduleDao.getSchedule(schedule_idx);
		
		if (schedule == null) {
			return Ut.jsHistoryBack("F-D", "존재하지 않는 일정입니다");
		}
		
		scheduleDao.editSchedule(schedule_idx, schedule_subject, schedule_desc, schedule_startdate, schedule_enddate);
		
		return Ut.jsReplace("S-1", "수정완료", "../calendar/do");
		
	}

}
