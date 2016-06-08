package com.sist.aop;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sist.bestorworst.BestOrWorstDriver;
import com.sist.mapredEmotion.EmotionDriver;
import com.sist.mapredWhen.WhenDriver;
import com.sist.mapredWho.WhoDriver;
@Aspect
@Component
public class aspect {
	
	@Autowired
	private EmotionDriver ed;
	@Autowired
	private WhoDriver wd;
	@Autowired
	private WhenDriver whend;
	@Autowired
	private BestOrWorstDriver bowd;
	
	//1.emotion
    @Before("execution(* com.sist.mapredEmotion.EmotionDriver.jobCall())")
    public void beforeEmotion()
    {
    	ed.fileDelete();
    	ed.copyFromLocal();
    }
    
    @After("execution(* com.sist.mapredEmotion.EmotionDriver.jobCall())")
    public void afterEmotion()
    {
    	ed.copyToLocal();
    }
    

	//2.who
    @Before("execution(* com.sist.mapredWho.WhoDriver.jobCall())")
    public void beforeWho()
    {
    	wd.fileDelete();
    	wd.copyFromLocal();
    }
    
    @After("execution(* com.sist.mapredWho.WhoDriver.jobCall())")
    public void afterWho()
    {
    	wd.copyToLocal();
    }

	//3.when
    @Before("execution(* com.sist.mapredWhen.WhenDriver.jobCall())")
    public void beforeWhen()
    {
    	whend.fileDelete();
    	whend.copyFromLocal();
    }
    
    @After("execution(* com.sist.mapredWhen.WhenDriver.jobCall())")
    public void afterWhen()
    {
    	whend.copyToLocal();
    }

	//4.BestOrWorst
    @Before("execution(* com.sist.bestorworst.BestOrWorstDriver.jobCall())")
    public void beforeBestOrWorst()
    {
    	bowd.fileDelete();
    	bowd.copyFromLocal();
    }
    
    @After("execution(* com.sist.bestorworst.BestOrWorstDriver.jobCall())")
    public void afterBestOrWorst()
    {
    	bowd.copyToLocal();
    }

  
}




