package com.company.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.company.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class LoginInterceptor extends HandlerInterceptorAdapter{
	private final String LOGIN = "userid";
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		HttpSession session = req.getSession();
		if(session.getAttribute(LOGIN)!=null) {
			log.info("이전 로그인 정보를 삭제합니다.");
			session.removeAttribute(LOGIN);
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse res, Object Handler, ModelAndView mav) throws Exception {
		HttpSession session = req.getSession();
		ModelMap modelMap = mav.getModelMap();
		MemberVO memberVO = (MemberVO) modelMap.get("memberVO");
		if(memberVO != null) {
			log.info("로그인 성공");
			
/*			if(req.getParameter("remember") != null) {
				// 쿠키 생성
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				// 장기 보관 메서드(7일)
				loginCookie.setMaxAge(60*60*24*7);
				res.addCookie(loginCookie);
			}*/
			
			session.setAttribute(LOGIN, memberVO.getUserid());
			String referer = req.getHeader("Referer");
			res.sendRedirect(referer);
		}else {
			log.info("로그인 실패");
			modelMap.addAttribute("msg", "아이디나 비밀번호가 올바르지 않습니다.");
		}
	}
}
