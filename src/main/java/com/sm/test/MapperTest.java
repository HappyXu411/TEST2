package com.sm.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.*;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.*;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.*;
import com.sm.bean.Department;
import com.sm.dao.DepartmentMapper;
import com.sm.bean.Employee;
import com.sm.dao.EmployeeMapper;
/**
 * 
 * 	测试dao层的工作
 * @author Administrator
 * 推荐使用spring项目可以使用spring的单元测试，可以自动注入我们需要的组件
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.直接autowired要使用的组件
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	/**
	 * 测试departmentMapper
	 */
	@Test
	public void testCRUD() {
		/*//1.创建springIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("");
		//2.从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		
		System.out.println(departmentMapper);
		
		//1.插入几个部门
		
		//departmentMapper.insertSelective(new Department(null,"开发部"));
		//departmentMapper.insertSelective(new Department(null,"调试部"));
		
		//2.生成员工数据，测试员工插入
		//employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@qq.com", 1));
		
		//3.批量插入多个员工，使用可以批量执行的sqlSession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i < 1000;i++) {
			String uId = UUID.randomUUID().toString().substring(0,5) + i;
			mapper.insertSelective(new Employee(null, uId, "M", uId + "@qq.com", 1));
		}
		
	}
}
