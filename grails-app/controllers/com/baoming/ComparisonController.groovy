package com.baoming

import grails.plugin.jxl.builder.ExcelBuilder
import org.apache.commons.io.IOUtils

class ComparisonController {

    def excelService
    def springSecurityService

    def index() {}

    def sub() {
        def userId = springSecurityService.authentication.principal?.id as String
        Comp.executeUpdate("delete from Comp where uid=?",[userId])
        def s = System.currentTimeMillis()
        def file = request.getFile("docFile")
        def file1 = request.getFile("docFile1")
        def map = excelService.toList(file, 'a',userId)
        def mapB = excelService.toList(file1, 'b',userId)
        def list = map?.list//excelService.toList(file, 'a')
        def list1 = mapB?.list//excelService.toList(file1, 'b')
        def titlesA = map?.titles
        def titlesB = mapB?.titles
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
        session['titlesA']=titlesA
        session['titlesB']=titlesB
        render(view: 'index', model: [a: list?.size(), b: list1?.size(), ab: newList?.size()])
    }

    def d(String type){
        def userId = springSecurityService.authentication.principal?.id as String
        def list
        def listB
        def titlesA = session['titlesA']
        def titlesB = session['titlesB']
        if(type == 'a'){
            list = session['listA']
            list = Comp.findAllByNumInListAndTypeAndUid(list,'a',userId)
        }else if(type == 'ab'){
            list = session['listAB']
            listB = list
            list = Comp.findAllByNumInListAndTypeAndUid(list,'a',userId)
            listB = Comp.findAllByNumInListAndTypeAndUid(listB,'b',userId)
        }else if(type == 'b'){
            list = session['listB']
            list = Comp.findAllByNumInListAndTypeAndUid(list,'b',userId)
        }

        def outputStream
        try {
            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'comparison.label')}${type}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    if(type == 'a'){
                        titlesA.eachWithIndex{s,j->
                            cell(j,0,s?:' ').bold()
                        }
                    }
                    if(type == 'ab'){
                        int ii = 0
                        titlesA.eachWithIndex{s,j->
                            cell(j,0,s?:' ').bold()
                            ii++
                        }
                        titlesB.eachWithIndex{s,j->
                            cell(j+ii,0,s?:' ').bold()
                        }
                    }
                    if(type == 'b'){
                        titlesB.eachWithIndex{s,j->
                            cell(j,0,s?:' ').bold()
                        }
                    }
                    list.eachWithIndex {de,k->
                        def content = de.content.tokenize(",")

                        int i = 0

                        int kk = k + 1

                        content.eachWithIndex{s,j->
                            cell(j,kk,s?:' ')
                            i++
                        }
                        if(type == 'ab'){
                            try {
                                def contentB = listB[k].content.tokenize(",")
                                contentB.eachWithIndex{s,j->
                                    cell(i+j,kk,s?:' ')
                                }
                            } catch (Exception e) {
                                log.error(e.message,e)
                            }
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
