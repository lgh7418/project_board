package com.company.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;


//해당 객체가 스프링의 컨트롤러에서 예외를 처리하는 존재임을 명시
@ControllerAdvice
public class CommonExceptionAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
	// 메서드가 ()에 들어가는 예외 타입을 처리한다는 것을 의미
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		logger.error("예외!! " + ex.getMessage());
		model.addAttribute("exception", ex);
		logger.error(model.toString());
		return "error_page";
		
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
	    return "custom404";
	}
}
