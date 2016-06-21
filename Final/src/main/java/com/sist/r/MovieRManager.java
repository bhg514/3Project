package com.sist.r;

import org.bson.util.StringRangeSet;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Component;
import java.util.*;

@Component
public class MovieRManager {
	
	

	public void rGraph(){
		try{
			RConnection rc = new RConnection();
			rc.voidEval("data<-read.table(\"/home/bhg/git/final/Final/src/main/webapp/output/part-r-00000\")");
			
			rc.voidEval("png(\"/home/bhg/git/final/Final/src/main/webapp/text/feel.png\",width=900,height=500)");
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
				
				
				}catch(Exception ex){
					System.out.println(ex.getMessage());
				}
				return who_count;
			
			}
			public static String[] wordcloud(){
				String[] word=new String[20];
				try{
					RConnection rc=new RConnection();
					rc.voidEval("library(KoNLP)");
					rc.voidEval("data<-readLines(\"/home/bhg/git/3Project/Final/src/main/webapp/text/movieDetail.txt\")");		
					rc.voidEval("place<-sapply(data,extractNoun,USE.NAMES = F)");				
					rc.voidEval("data<-unlist(place)");					
					rc.voidEval("place<-str_replace_all(data,\"[^[:alpha:]]\",\"\")");					
					rc.voidEval("place<-gsub(\" \",\"\",place)");
					rc.voidEval("place<-Filter(function(x){nchar(x)>=2},place)");
					rc.voidEval("rev<-table(unlist(place))");
					rc.voidEval("top20<-head(sort(rev,decreasing = T),20)");
					REXP p=rc.eval("names(top20)");
					word=p.asStrings();
					
				}catch(Exception ex){
					System.out.println(ex.getMessage());
				
				}
				return word;
			}
			public static int[] wordCount(){
				int[] count=new int[20];
				try{
					RConnection rc=new RConnection();
					rc.voidEval("library(KoNLP)");
					rc.voidEval("data<-readLines(\"/home/bhg/git/3Project/Final/src/main/webapp/text/movieDetail.txt\")");		
					rc.voidEval("place<-sapply(data,extractNoun,USE.NAMES = F)");				
					rc.voidEval("data<-unlist(place)");					
					rc.voidEval("place<-str_replace_all(data,\"[^[:alpha:]]\",\"\")");					
					rc.voidEval("place<-gsub(\" \",\"\",place)");
					rc.voidEval("place<-Filter(function(x){nchar(x)>=2},place)");
					rc.voidEval("rev<-table(unlist(place))");
					rc.voidEval("top20<-head(sort(rev,decreasing = T),20)");
					REXP p=rc.eval("top20");
					count=p.asIntegers();
					
				}catch(Exception ex){
					System.out.println(ex.getMessage());
				
				}
				return count;
			}
				
}
