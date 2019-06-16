package com.company.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.company.domain.BoardVO;
import com.company.domain.Criteria;
import com.company.domain.PageDTO;
import com.company.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
	    log.info("list: " + cri);
	    model.addAttribute("list", service.getList(cri));
	    
		int total = service.getTotal(cri);
		log.info("total: " + total);
	    
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		log.info(new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
	    log.info("register: " + board);
	    
	    service.register(board);
	    rttr.addFlashAttribute("result", board.getBno());
	    log.info("result: " + board.getBno());
	    return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// @ModelAttribute는 자동으로 Model에 데이터를 지정한 이름으로 담아줌
		log.info("/get");
	    model.addAttribute("board", service.getWithView(bno));
	}
	
	@GetMapping("/modify" )
	public void modifyGET(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/modify");
	    model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);

		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		// 수정한 페이지로 리다이렉트하게 고치기!
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
	    log.info("remove..." + bno);
	    if (service.remove(bno)) {
	        rttr.addFlashAttribute("result", "success");
	    }
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
	    return "redirect:/board/list";
	}
	
	@GetMapping("/mypage")
	public String mypage(Criteria cri, HttpSession session, Model model) {
		String keyword = (String) session.getAttribute("userid");
		cri.setKeyword(keyword);
		cri.setType("W");
		
		log.info("list: " + cri);
	    model.addAttribute("list", service.getList(cri));
	    
		int total = service.getTotal(cri);
		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));
		log.info(new PageDTO(cri, total));
		
		//return "redirect:/member/mypage";
		return "/member/mypage";
	}

}
