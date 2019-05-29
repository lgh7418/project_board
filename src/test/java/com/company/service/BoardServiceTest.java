package com.company.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.company.config.RootConfig;
import com.company.domain.BoardVO;
import com.company.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class BoardServiceTest {
	
	@Setter(onMethod_ = { @Autowired })
	private BoardService service;

	//@Test
	public void testExist() {

		log.info(service);
		assertNotNull(service);
	}

	//@Test
	public void testRegister() {

		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");

		service.register(board);
		
		// mapper의 insertSelectKey() 결과로 board에 bno를 설정하므로 bno를 확인할 수 있음
		log.info("생성된 게시물의 번호: " + board.getBno());
	}
	
	@Test
	public void testGetList() {

		service.getList(new Criteria(2, 10)).forEach(board -> log.info(board));
	}
	
	//@Test
	public void testGet() {

		log.info(service.get(1L));
	}
	
	//@Test
	public void testUpdate() {

		BoardVO board = service.get(23L);

		if (board == null) {
			return;
		}

		board.setTitle("제목 수정합니다.");
		log.info("MODIFY RESULT: " + service.modify(board));
	}
	
	//@Test
	public void testDelete() {

		log.info("REMOVE RESULT: " + service.remove(23L));

	}

}
