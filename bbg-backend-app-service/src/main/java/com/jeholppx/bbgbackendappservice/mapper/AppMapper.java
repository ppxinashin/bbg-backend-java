package com.jeholppx.bbgbackendappservice.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jeholppx.bbgbackendmodel.model.dto.userAnswer.AppAnswerCountDTO;
import com.jeholppx.bbgbackendmodel.model.dto.userAnswer.AppAnswerResultCountDTO;
import com.jeholppx.bbgbackendmodel.model.entity.App;
import org.apache.ibatis.annotations.Select;

import java.util.List;


/**
* @author billz
* @description 针对表【app(应用)】的数据库操作Mapper
* @createDate 2024-10-14 10:58:22
* @Entity com.jeholppx.bbg.model.entity.App
*/
public interface AppMapper extends BaseMapper<App> {
    @Select("select appId, count(userId) as answerCount from user_answer " +
            "group by appId order by answerCount desc")
    List<AppAnswerCountDTO> doAppAnswerCount();

    @Select("select resultName, count(resultName) as resultCount from user_answer " +
            "where appId = #{appId} group by resultName order by resultCount desc")
    List<AppAnswerResultCountDTO> doAppAnswerResultCount(Long appId);
}




