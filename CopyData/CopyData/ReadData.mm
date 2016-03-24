//
//  ReadData.c
//  CopyData
//
//  Created by zdy on 15/9/21.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#include "ReadData.h"
#import "DBManager.h"
#include<stdio.h>
#import "ExamPaper.h"

void readDataToSQLite()
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:500];
    
    int section = 167;
    int noInPaper = 201;
    int line = 0;
    char StrLine[10240];
    FILE *file;
    if((file = fopen("/Users/zdy/Desktop/examData/护师专业知识8","r")) != NULL){
        NSString *title = @"";
        NSString *optionA = @"";
        NSString *optionB = @"";
        NSString *optionC = @"";
        NSString *optionD = @"";
        NSString *optionE = @"";
        NSString *answer = @"";
        NSString *des = @"";
        
        while(!feof(file)){
            fgets(StrLine,10240,file);
            printf("%s\n",StrLine);
            
            
            NSString *lineStr = [NSString stringWithUTF8String:StrLine];
            NSString *str = [lineStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([lineStr isEqualToString:@"\n"]) {
                if (line == 0) {
                    break;
                }
                // 读完一题，构成一道题
                ExamPaper *paper = [[ExamPaper alloc] init];
                paper.subjectTitle = [NSString stringWithFormat:@"%d.%@",noInPaper,title];
                paper.optionA = optionA;
                paper.optionB = optionB;
                paper.optionC = optionC;
                paper.optionD = optionD;
                paper.optionE = optionE;
                paper.rightAnswer = [answer intValue];
                paper.selectAnswer = 0;
                paper.des = des;
                paper.noInPaper = [NSString stringWithFormat:@"%d",noInPaper];
                paper.sectionId = [NSString stringWithFormat:@"%d",section];
                [array addObject:paper];
                
                line =0;
                noInPaper ++;
                section =167 + (noInPaper - 201)/10;
                des = @"";
                
            }
            else {
                if(line ==0){
                    // 标题
                    title = str;
                }
                else if(line==1){
                    // A
                    optionA=str;
                }
                else if(line==2){
                    // B
                    optionB = str;
                }
                else if(line ==3){
                    // C
                    optionC = str;
                }
                else if(line==4){
                    // D
                    optionD = str;
                }
                else if(line==5){
                    // E
                    optionE = str;
                }
                else if(line==6){
                    // answer
                    answer = str;
                }
                else if(line==7){
                    // 解释
                    des = str;
                }
                
                line++;
            }

            
        }
    }
    
    for (ExamPaper *paper in array) {
        [[DBManager shareManager] addExamPaper:paper];
    }
}
