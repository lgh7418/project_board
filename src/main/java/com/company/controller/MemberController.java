package com.company.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.company.domain.Criteria;
import com.company.domain.MemberVO;
import com.company.domain.PageDTO;
import com.company.service.BoardService;
import com.company.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	@Setter(onMethod_ = { @Autowired })
	private MemberService service;
	
	@Setter(onMethod_ = { @Autowired })
	private BoardService boardService;
	
	@Setter(onMethod_ = { @Autowired })
	private BCryptPasswordEncoder pwEncoder;
	
	@GetMapping("/loginForm")
	public String loginForm(HttpServletRequest request, RedirectAttributes rttr) {
		rttr.addFlashAttribute("loginModal", true);

	    String referer = request.getHeader("Referer");
	    return "redirect:"+ referer;
	}
	
	@PostMapping("/login")
	public String login(MemberVO vo, Model model) {
		log.info("login: " + vo);
		service.login(vo);
		model.addAttribute("memberVO", vo);
		return "/board/list";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) throws Exception {
		log.info("logout!!");
		session.invalidate();
		rttr.addFlashAttribute("msg", "로그아웃되었습니다.");
		return "redirect:/board/list";
	}
	
	@PostMapping("/checkJoin")
	public @ResponseBody String checkJoin(@RequestParam("userid") String userid) {
		String str = "";
		String idcheck = service.idCheck(userid);
		if(idcheck != null){ //이미 존재하는 계정
			str = "no";	
		}else{	//사용 가능한 계정
			str = "yes";	
		}
		return str;
	}
	
	@PostMapping("/join")
	public String join(MemberVO vo, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		String inputPw = vo.getUserpw();
		String pw = pwEncoder.encode(inputPw);
		vo.setUserpw(pw);
		log.info(vo);
		service.join(vo);
		rttr.addFlashAttribute("msg", "가입되었습니다");
		String referer = request.getHeader("Referer");
	    return "redirect:"+ referer;
	}
	
	@GetMapping("/info/{userid}")
	public String info(Criteria cri, @PathVariable("userid") String userid, Model model) {
		cri.setKeyword(userid);
		cri.setType("W");
		
		log.info("list: " + cri);
	    model.addAttribute("list", boardService.getList(cri));
	    
		int total = boardService.getTotal(cri);
		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));
		log.info(new PageDTO(cri, total));
		
		return "/member/info";
	}
}
