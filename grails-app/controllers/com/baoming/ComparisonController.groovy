package com.baoming

import grails.plugin.jxl.builder.ExcelBuilder
import org.apache.commons.io.IOUtils

class ComparisonController {

    def excelService

    def index() {}

    def sub() {
        Comp.executeUpdate("delete from Comp")
        def s = System.currentTimeMillis()
        def file = request.getFile("docFile")
        def file1 = request.getFile("docFile1")
        def list = excelService.toList(file, 'a')
        def list1 = excelService.toList(file1, 'b')
        def s1 = System.currentTimeMillis()

        log.info("s1 - s :${s1 - s}")

        def newList = list.findAll {
            list1.count(it) > 0
        }

        def s2 = System.currentTimeMillis()
        log.info("s2 - s1 :${s2 - s1}")

        list.removeAll(newList)
        def s3 = System.currentTimeMillis()
        log.info("s3 - s2 :${s3 - s2}")
        list1.removeAll(newList)
        def s4 = System.currentTimeMillis()
        log.info("s4 - s3 :${s4 - s3}")
        session['listA']=list
        session['listB']=list1
        session['listAB']=newList
        render(view: 'index', model: [a: list?.size(), b: list1?.size(), ab: newList?.size()])
    }

    def d(String type){
        def list
        if(type == 'a'){
            list = session['listA']
            list = Comp.findAllByNumInListAndType(list,'a')
        }else if(type == 'ab'){
            list = session['listAB']
            list = Comp.findAllByNumInListAndType(list,'a')
        }else if(type == 'b'){
            list = session['listB']
            list = Comp.findAllByNumInListAndType(list,'b')
        }

        def outputStream
        try {
            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'comparison.label')}${type}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    list.eachWithIndex {de,k->
                        def content = de.content.tokenize(",")
                        content.eachWithIndex{s,j->
                            cell(j,k,s?:' ')
                        }
                    }
                }
            }
            //
        } catch (Exception e) {
            flash.message = message(code: 'download.null.message')
            log.error("ComparisonController errors:${e.message}",e)
        } finally {
            IOUtils.closeQuietly(outputStream)
        }
        return


    }


}
