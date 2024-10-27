package com.jeholppx.bbgbackendcommon.utils;

import cn.hutool.json.JSONUtil;
import cn.hutool.jwt.JWT;
import cn.hutool.jwt.JWTUtil;
import cn.hutool.jwt.signers.JWTSigner;
import cn.hutool.jwt.signers.JWTSignerUtil;
import com.jeholppx.bbgbackendcommon.common.ErrorCode;
import com.jeholppx.bbgbackendcommon.exception.BusinessException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.util.Calendar;

/**
 * JWT 工具
 *
 * @author <a href="https://www.jehol-ppx.com">热河fen青</a>
 * @base HuTool
 * @date 2024/10/21 16:48
 */
@Component
public class JWTUtils {

    /**
     * hs256签名
     */
    private static final byte[] SIGN = "JEHOLFENQ".getBytes();

    /**
     * 默认过期时长 单位：天
     */
    private static final int EXPIRATION_DATE = 3;

    /**
     * 生成token，并存储用户信息到Redis
     *
     * @param user
     * @return
     */
    public static String getter(Object user) {
        Calendar instance = Calendar.getInstance();
        instance.add(Calendar.DATE, EXPIRATION_DATE);
        // 创建jwt对象
        JWT jwt = JWT.create();
        String jsonStr = JSONUtil.toJsonStr(user);
        jwt.setPayload("user", jsonStr);
        // 设置过期时间并签名
        JWTSigner signer = JWTSignerUtil.hs256(SIGN);
        String token = jwt.setExpiresAt(instance.getTime())
                .sign(signer);
        return token;
    }

    /**
     * 解析token
     *
     * @param token
     * @param clazz
     * @return
     */
    public static Object decode(String token, Class<?> clazz) throws BusinessException {
        // 先判断token是否有效，无效直接要求重新登录
        boolean invalid = !JWTUtil.verify(token, JWTSignerUtil.hs256(SIGN));
        if (invalid) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "请重新登录");
        }
        // 解析token
        String userJsonStr = (String) JWTUtil.parseToken(token).getPayload("user");
        if (StringUtils.isBlank(userJsonStr)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "请重新登录");
        }
        return JSONUtil.toBean(userJsonStr, clazz);
    }


}
