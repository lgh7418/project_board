package com.company.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class Criteria {
    
    private int pageNum;
    private int amount;
    
    // 기본값. 1 페이지, 한 페이지당 10개의 글을 보여줌
    public Criteria() {
        this(1, 10);
    }
    
    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
