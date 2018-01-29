package com.bt.om.mapper;

import com.bt.om.entity.SysUserExecute;

public interface SysUserExecuteMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sys_user_execute
     *
     * @mbggenerated Tue Jan 23 17:12:28 CST 2018
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sys_user_execute
     *
     * @mbggenerated Tue Jan 23 17:12:28 CST 2018
     */
    int insert(SysUserExecute record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sys_user_execute
     *
     * @mbggenerated Tue Jan 23 17:12:28 CST 2018
     */
    int insertSelective(SysUserExecute record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sys_user_execute
     *
     * @mbggenerated Tue Jan 23 17:12:28 CST 2018
     */
    SysUserExecute selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sys_user_execute
     *
     * @mbggenerated Tue Jan 23 17:12:28 CST 2018
     */
    int updateByPrimaryKeySelective(SysUserExecute record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sys_user_execute
     *
     * @mbggenerated Tue Jan 23 17:12:28 CST 2018
     */
    int updateByPrimaryKey(SysUserExecute record);

    SysUserExecute selectByUsername(String username);
}