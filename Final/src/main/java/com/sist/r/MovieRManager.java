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

	 
	 public String[] feel() {
	      String[] feel =new String[6];
	      try{
	         RConnection rc = new RConnection();
	         
	         rc.voidEval("data<-read.table(\"/home/sist/git/3Project/Final/src/main/webapp/text/output/emotion/part-r-00000\")");
	         rc.voidEval("data<-data[order(data$V2,decreasing=T),c(\"V1\",\"V2\")]");

	         REXP p = rc.eval("data$V1");
	         feel= p.asStrings();

	         
	         
	      }catch(Exception ex){
	         System.out.println(ex.getMessage());
	      }
	      return feel;

	   }
	 
	   public int[] count() {
		   
	      int[] count=new int[6];
	      try{
	         RConnection rc = new RConnection();
	         
	         rc.voidEval("data<-read.table(\"/home/sist/git/3Project/Final/src/main/webapp/text/output/emotion/part-r-00000\")");
	         rc.voidEval("data<-data[order(data$V2,decreasing=T),c(\"V1\",\"V2\")]");

	         REXP p = rc.eval("data$V2");
	         count = p.asIntegers();
	         
	         	System.out.println(count);
	      }catch(Exception ex){
	         System.out.println(ex.getMessage());
	      }
	      return count;

	   }
	
}
