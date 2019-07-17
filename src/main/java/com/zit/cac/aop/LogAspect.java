package com.zit.cac.aop;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.AfterReturning;  
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.zit.cac.entity.Log;
import com.zit.cac.entity.User;
import com.zit.cac.service.LogService;
import com.zit.cac.util.IpUtil;
import com.zit.cac.util.TimeUtil;

/**
 *@author: wangq
 *@date: 2015-8-4下午03:27:38
 *@version:
 *@description：
 */

@Aspect
public class LogAspect {
	
	@Autowired
	private LogService<Log> logService;
	
	/** 
     * 添加业务逻辑方法切入点 
     */ 
	@Pointcut("execution(* com.zit.service.*.add*(..))")  
	public void addServiceCall() { }  
	
	/** 
     * 修改业务逻辑方法切入点 
     */  
    @Pointcut("execution(* com.zit.service.*.update*(..))")  
    public void updateServiceCall() { }  
    
    
    /** 
     * 删除业务逻辑方法切入点 
     * 此处拦截要拦截到具体的莫一个模块
     * 如deleteUser方法。则删除user的时候会记录日志
     * deleteRole时删除role会记录日志
     */  
    @Pointcut("execution(* com.zit.service.*.delete*(..))")  
    public void deleteServiceCall() { }  
      
	
    /** 
     * 管理员添加操作日志(后置通知) 
     * @param joinPoint 
     * @param rtv 
     * @throws Throwable 
     */  
    @AfterReturning(value="addServiceCall()", argNames="rtv", returning="rtv")  
    public void insertServiceCallCalls(JoinPoint joinPoint, Object rtv) throws Throwable{  
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	User currentUser = (User) request.getSession().getAttribute("currentUser");
        //判断参数  
        if(joinPoint.getArgs() == null){
            return;  
        }  
        //获取方法名  
        //String methodName = joinPoint.getSignature().getName();  
        String className = joinPoint.getArgs()[0].getClass().getName();
        //获取操作内容  
		className = className.substring(className.lastIndexOf(".") + 1);
        String opContent = adminOptionContent(joinPoint.getArgs(), "添加");  
         
        //创建日志对象  
        Log log = new Log();
        log.setModule(className.toLowerCase());
        log.setUserName(currentUser.getUserName());
        //操作时间 
        log.setCreateTime(TimeUtil.formatTime(new Date(),"yyyy-MM-dd HH:mm:ss"));
        //操作内容  
        log.setContent(opContent);
        //操作
        log.setOperation("添加");
        log.setIp(IpUtil.getIpAddr(request));
        logService.insertLog(log);
    }  
    
    
    
    
    /** 
     * 管理员修改操作日志(后置通知) 
     * @param joinPoint 
     * @param rtv 
     * @throws Throwable 
     */ 
    @AfterReturning(value="updateServiceCall()", argNames="rtv", returning="rtv")  
    public void updateServiceCallCalls(JoinPoint joinPoint, Object rtv) throws Throwable{  
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	User currentUser = (User) request.getSession().getAttribute("currentUser");
       
          
        //判断参数  
        if(joinPoint.getArgs() == null){ 
            return;  
        }  
        //获取方法名  
        String className = joinPoint.getArgs()[0].getClass().getName();
		className = className.substring(className.lastIndexOf(".") + 1);
        //获取操作内容  
        String opContent = adminOptionContent(joinPoint.getArgs(), "修改");  
        Log log = new Log();  
        log.setModule(className.toLowerCase());
        log.setUserName(currentUser.getUserName()); 
        //操作时间  
        log.setCreateTime(TimeUtil.formatTime(new Date(),"yyyy-MM-dd HH:mm:ss"));
        //操作
        log.setContent(opContent);
        log.setOperation("修改");
        log.setIp(IpUtil.getIpAddr(request));
        //添加日志  
        logService.insertLog(log);
    }  
    
    
	/**
	 * 使用Java反射来获取被拦截方法(insert、update)的参数值， 将参数值拼接为操作内容
	 */
	public String adminOptionContent(Object[] args, String type) throws Exception {
		if (args == null) {
			return null;
		}
		StringBuffer sb = new StringBuffer();
		Object info = args[0];
		String className = info.getClass().getName();
		className = className.substring(className.lastIndexOf(".") + 1);
		sb.append(type+className+" 属性名和值：");
		// 获取对象的所有方法
		Method[] methods = info.getClass().getDeclaredMethods();
		// 遍历方法，判断get方法
		for (Method method : methods) {
			String methodName = method.getName();
			// 判断是不是get方法
			if (methodName.indexOf("get") == -1) {
				continue;// 不处理
			}
			Object rsValue = null;
			try {
				// 调用get方法，获取返回值
				rsValue = method.invoke(info);
				if (rsValue == null) {
					continue;
				}
			} catch (Exception e) {
				continue;
			}
			// 将值加入内容中
			sb.append(" " + methodName.substring(3) + "-->" + rsValue + "  ");
		}
		return sb.toString();
	}
	
	 /** 
     * 管理员删除XX操作(环绕通知)，使用环绕通知的目的是 
     * 在XX被删除前可以先查询出信息用于日志记录
     * 删除操作参数是ID，所以要指定模块。
     * 在上面的aop拦截中，拦截具体的莫一个模块的删除方法。 
     * @param joinPoint 
     * @param rtv 
     * @throws Throwable 
    
    @Around(value="deleteFilmCall()", argNames="rtv")  
    public Object deleteFilmCallCalls(ProceedingJoinPoint pjp) throws Throwable {  
          
        Object result = null;  
         //环绕通知处理方法  
         try {  
              
            //获取方法参数(被删除的id)  
            Integer id = (Integer)pjp.getArgs()[0];  
            Object obj = null;//对象  
            if(id != null){  
                //删除前先查询出对象  
                obj = filmService.getFilmById(id);  
            }  
              
            //执行删除操作  
            result = pjp.proceed();  
              
            if(obj != null){  
                  
                //创建日志对象  
                  
                log.setOperation("删除");//操作  
                  
                logService.log(log);//添加日志  
            }  
              
         }  
         catch(Exception ex) {  
            ex.printStackTrace();  
         }  
           
         return result;  
    }  
    
     */  
 
    
    
	
}
