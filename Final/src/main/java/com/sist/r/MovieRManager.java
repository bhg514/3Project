package com.sist.r;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Component;
import java.util.*;

@Component
public class MovieRManager {

	 public String[] feel() {
	      String[] feel =new String[6];
	      try{
	         RConnection rc = new RConnection();
	         
	         rc.voidEval("data<-read.table(\"/home/bhg/git/3Project/Final/src/main/webapp/text/output/emotion/part-r-00000\")");
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
	         
	         rc.voidEval("data<-read.table(\"/home/bhg/git/3Project/Final/src/main/webapp/text/output/emotion/part-r-00000\")");
	         rc.voidEval("data<-data[order(data$V2,decreasing=T),c(\"V1\",\"V2\")]");

	         REXP p = rc.eval("data$V2");
	         count = p.asIntegers();
	         
	         	System.out.println(count);
	      }catch(Exception ex){
	         System.out.println(ex.getMessage());
	      }
	      return count;

	   }
	   ///////////////////////////////////////////////////////////////////////////////////////
	   public String[] who() {
		      String[] who =new String[6];
		      try{
		         RConnection rc = new RConnection();
		         
		         rc.voidEval("data<-read.table(\"/home/bhg/git/3Project/Final/src/main/webapp/text/output/who/part-r-00000\")");
	

		         REXP p = rc.eval("data$V1");
		         who = p.asStrings();

		         
		         
		      }catch(Exception ex){
		         System.out.println(ex.getMessage());
		      }
		      return who;

		   }
		 
		   public int[] who_count() {
			   
		      int[] who_count=new int[6];
		      try{
		         RConnection rc = new RConnection();
		         
		         rc.voidEval("data<-read.table(\"/home/bhg/git/3Project/Final/src/main/webapp/text/output/who/part-r-00000\")");
		
		         REXP p = rc.eval("data$V2");
		         who_count = p.asIntegers();
		         
		         	System.out.println(who_count);
		      }catch(Exception ex){
		         System.out.println(ex.getMessage());
		      }
		      return who_count;

		   }
///////////////////////////////////////////////////////////////////////////////////////
			public String[] bestorworst() {
			String[] who =new String[6];
			try{
				RConnection rc = new RConnection();
			
				rc.voidEval("data<-read.table(\"/home/bhg/git/3Project/Final/src/main/webapp/text/output/bestorworst/part-r-00000\")");

				
				REXP p = rc.eval("data$V1");
				who = p.asStrings();
				
				
				
			}catch(Exception ex){
				System.out.println(ex.getMessage());
			}
				return who;
			
			}
			
			public int[] bestorworst_count() {
			
				int[] who_count=new int[6];
				try{
				RConnection rc = new RConnection();
				
				rc.voidEval("data<-read.table(\"/home/bhg/git/3Project/Final/src/main/webapp/text/output/bestorworst/part-r-00000\")");
				
				REXP p = rc.eval("data$V2");
				who_count = p.asIntegers();
				
				System.out.println(who_count);
				}catch(Exception ex){
					System.out.println(ex.getMessage());
				}
				return who_count;
			
			}
				
}
