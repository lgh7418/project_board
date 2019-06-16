package com.company.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import com.company.interceptor.AuthInterceptor;
import com.company.interceptor.LoginInterceptor;
import com.company.mapper.BoardMapper;

import lombok.Setter;

@EnableWebMvc
@ComponentScan(basePackages= {"com.company.controller", "com.company.exception"})
public class ServletConfig implements WebMvcConfigurer {
	
/*	@Autowired
    private LoginInterceptor loginInterceptor;*/
	
	/*@Setter(onMethod_ = @Autowired)
	private AuthInterceptor authInterceptor;*/
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		bean.setViewClass(JstlView.class);
		bean.setPrefix("/WEB-INF/views/");
		bean.setSuffix(".jsp");
		registry.viewResolver(bean);
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginInterceptor())
			.addPathPatterns("/member/login");
		
		 registry.addInterceptor(new AuthInterceptor())
	         .addPathPatterns("/board/modify")
	         .addPathPatterns("/board/register");
	}
	

}
