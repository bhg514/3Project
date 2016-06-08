package com.sist.r;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Component;
import java.util.*;

@Component
public class MovieRManager {

	public void rGraph(){
		try{
			RConnection rc = new RConnection();
			rc.voidEval("data<-read.table(\"/home/sist/git/final/Final/src/main/webapp/output/part-r-00000\")");
			rc.voidEval("png(\"/home/sist/git/final/Final/src/main/webapp/text/feel.png\",width=900,height=500)");
			rc.voidEval("par(mfrow=c(1,2))"); // 그래프 여러개 합칠때 1,2는 1줄에 두개
			rc.voidEval("pie(data$V2,labels=data$V1,col=rainbow(10))");
			rc.voidEval("barplot(data$V2,names.arg=data$V1,col=rainbow(10))");
			rc.voidEval("dev.off()");
			rc.close();
			
		}catch(Exception ex){System.out.println(ex.getMessage());}
	}
	
	// 데이터 받기 => 몽고
	public List<FeelVO> rFeelData(){
		List<FeelVO> list = new ArrayList<FeelVO>();
		try{
			RConnection rc = new RConnection();
			rc.voidEval("data<-read.table(\"/home/sist/git/final/Final/src/main/webapp/output/part-r-00000\")");
			
			REXP p = rc.eval("data$V1");		// R에서 데이터 받을 때
			String[] feel = p.asStrings();
			
			p = rc.eval("data$V2");
			int[] count = p.asIntegers();
			
			rc.close();
			
			for(int i=0; i<count.length; i++){
				if(count[i]>=3){
					FeelVO vo = new FeelVO();
					vo.setFeel(feel[i]);
					vo.setCount(count[i]);
					list.add(vo);
				}
			}
			
		}catch(Exception ex){System.out.println(ex.getMessage());}
		
		return list;
	}
	
	
}
