package com.jeholppx.bbgbackendserviceclient.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.jeholppx.bbgbackendcommon.common.ErrorCode;
import com.jeholppx.bbgbackendcommon.constant.UserConstant;
import com.jeholppx.bbgbackendcommon.exception.BusinessException;
import com.jeholppx.bbgbackendcommon.utils.JWTUtils;
import com.jeholppx.bbgbackendmodel.model.dto.user.UserQueryRequest;
import com.jeholppx.bbgbackendmodel.model.entity.User;
import com.jeholppx.bbgbackendmodel.model.enums.UserRoleEnum;
import com.jeholppx.bbgbackendmodel.model.vo.LoginUserVO;
import com.jeholppx.bbgbackendmodel.model.vo.UserVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.List;

import static com.jeholppx.bbgbackendcommon.constant.UserConstant.TOKEN;

/**
 * 用户服务
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @date 2024/10/14 19:00
 */
@FeignClient(name = "bbg-backend-user-service", path = "/api/user/inner")
public interface UserFeignClient {

    /**
     * 获取当前登录用户
     *
     * @param request
     * @return
     */
    default User getLoginUser(HttpServletRequest request) {
        // 先判断是否已登录
        String token = (String) request.getSession().getAttribute(TOKEN);
        if (StringUtils.isBlank(token)) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
        }
        // 通过token解析用户信息
        return (User) JWTUtils.decode(token, User.class);
    }


    /**
     * 是否为管理员
     *
     * @param user
     * @return
     */
    default boolean isAdmin(User user) {
        return user != null && UserRoleEnum.ADMIN.getValue().equals(user.getUserRole());
    }

    /**
     * 获取脱敏的用户信息
     *
     * @param user
     * @return
     */
    default UserVO getUserVO(User user) {
        if (user == null) {
            return null;
        }
        UserVO userVO = new UserVO();
        BeanUtils.copyProperties(user, userVO);
        return userVO;
    }

    /**
     * 获取用户列表
     * @param id
     * @return
     */
    @GetMapping("/get/id")
    User getById(@RequestParam("userId") Long id);


    /**
     * 获取用户列表
     * @param ids
     * @return
     */
    @GetMapping("/get/ids")
    List<User> listByIds(@RequestParam("ids") Collection<Long> ids);



}
