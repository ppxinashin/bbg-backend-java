package com.jeholppx.bbgbackendmodel.model.dto.question;


import lombok.Data;
import lombok.EqualsAndHashCode;
import com.jeholppx.bbgbackendcommon.common.PageRequest;

import java.io.Serializable;

/**
 * 查询题目请求
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class QuestionQueryRequest extends PageRequest implements Serializable {

    /**
     * id
     */
    private Long id;

    /**
     * id
     */
    private Long notId;

    /**
     * 题目内容（json格式）
     */
    private String questionContent;

    /**
     * 创建用户 id
     */
    private Long userId;

    /**
     * 应用 id
     */
    private Long appId;

    private static final long serialVersionUID = 1L;
}