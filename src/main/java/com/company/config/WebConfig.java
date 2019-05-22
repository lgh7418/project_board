package com.company.config;

import javax.servlet.ServletRegistration;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	// root-context.xml을 대신하는 클래스를 지정
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] {RootConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] {ServletConfig.class};
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] {"/"};
	}

	// 404 not found 설정
	@Override
	protected void customizeRegistration(ServletRegistration.Dynamic registration) {

		registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");

	}
}
