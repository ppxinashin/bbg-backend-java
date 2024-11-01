package com.jeholppx.bbgbackendappservice.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.jeholppx.bbgbackendmodel.model.dto.app.AppQueryRequest;
import com.jeholppx.bbgbackendmodel.model.entity.App;
import com.jeholppx.bbgbackendmodel.model.vo.AppVO;


import javax.servlet.http.HttpServletRequest;

/**
 * 应用服务
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 
 */
public interface AppService extends IService<App> {

    /**
     * 校验数据
     *
     * @param app
     * @param add 对创建的数据进行校验
     */
    void validApp(App app, boolean add);

    /**
     * 获取查询条件
     *
     * @param appQueryRequest
     * @return
     */
    QueryWrapper<App> getQueryWrapper(AppQueryRequest appQueryRequest);
    
    /**
     * 获取应用封装
     *
     * @param app
     * @param request
     * @return
     */
    AppVO getAppVO(App app, HttpServletRequest request);

    /**
     * 分页获取应用封装
     *
     * @param appPage
     * @param request
     * @return
     */
    Page<AppVO> getAppVOPage(Page<App> appPage, HttpServletRequest request);
}
