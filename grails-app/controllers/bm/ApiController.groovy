package bm

import com.baoming.City
import com.baoming.Province
import com.baoming.District
import com.baoming.MiddleSchool
import org.apache.commons.io.IOUtils
import org.apache.commons.io.FileUtils
import jxl.Workbook
import jxl.Sheet
import jxl.Cell
import jxl.read.biff.BiffException
import grails.plugin.jxl.builder.ExcelBuilder


class ApiController {

    def provinceService
    def middleSchoolService

    def dataInit(){
      // def filePath = "classpath:all.sql"
       def filePath = ApiController.class.getResource('/all.sql')?.getPath()
        println(filePath)
       def file = new File(filePath)
        println(file)
       file.eachLine { line ->
            println "Line: ${line}"
        }
        render("ok")
    }

    def cityOpts() {
        def selectedId = params.selected
        def opts =  "<option value=''>${message(code: 'default.select.zd.message')}</option>"
        if(!params.id) {
             render opts
            return
        }
        def citys = provinceService.getCitys(params.id)

        citys?.each {c->
            if(c.code == selectedId) {
                opts += "<option value='${c.code}' selected='selected'>${c.name}</option>"
            }else{
                opts += "<option value='${c.code}'>${c.name}</option>"
            }

        }
        render opts
    }

    def districtOpts() {
        def selectedId = params.selected
        def opts = "<option value=''>${message(code: 'default.select.zd.message')}</option>"
        if(!params.id) {
            render opts
            return
        }
        def districts = provinceService.getDistricts(params.id)

        districts?.each {c->
            if(c.code == selectedId) {
                opts += "<option value='${c.code}' selected='selected'>${c.name}</option>"
            }else{
                opts += "<option value='${c.code}'>${c.name}</option>"
            }
        }
        render opts
    }

    def districtOfCityOpts() {
        def selectedId = params.selectedId
        selectedId = selectedId.tokenize(",")
        def citys = City.list()
        def opts =  "<option value=''>${message(code: 'default.select.zd.message')}</option>"
        if(!citys) {
            render opts
            return
        }
        citys.each {city->
            opts += "<optgroup label=\"${city.name}\">"
            def districts = city.districts
            districts?.each {c->
                if(selectedId.count(c.code) > 0) {
                    opts += "<option value='${c.code}' selected='selected'>${c.name}</option>"
                }else{
                    opts += "<option value='${c.code}'>${c.name}</option>"
                }
            }
            opts += "</optgroup>"
        }
        render opts
    }

    def schoolOpts() {
        def selectedId = params.long('selected')
        def opts = "<option value=''>${message(code: 'default.select.zd.message')}</option>"
        if(!params.id) {
            render opts
            return
        }

        def schools = middleSchoolService.getMiddleSchools(params.id)
        schools?.each {c->
            if(c.id == selectedId) {
                opts += "<option value='${c.id}' selected='selected'>${c.name}</option>"
            }else{
                opts += "<option value='${c.id}'>${c.name}</option>"
            }
        }
        render opts
    }

    def img(){
        def filename = params.id
        def storeFile = grailsApplication.config.baoming.image.storage.path + '/' + filename
        def f = new File(storeFile)
        if(!f.exists()){
            return
        }
        def inputStream = new FileInputStream(f)
        if(!inputStream) {
            return
        }
        def out = response.outputStream

        try {
            IOUtils.copy(inputStream,out)
        } catch (IOException e) {

        }finally{
            IOUtils.closeQuietly(inputStream)
            IOUtils.closeQuietly(out)
        }

    }

    def img1(){
        def filename = params.path
        if(!filename){
            return
        }
        println(filename)
        filename = filename.decodeURL()
        println(filename)

        def storeFile = grailsApplication.config.baoming.image.storage.path + '/' + filename
        def f = new File(storeFile)
        if(!f.exists()){
            return
        }
        def inputStream = new FileInputStream(f)
        if(!inputStream) {
            return
        }
        def out = response.outputStream

        try {
            IOUtils.copy(inputStream,out)
        } catch (IOException e) {

        }finally{
            IOUtils.closeQuietly(inputStream)
            IOUtils.closeQuietly(out)
        }

    }

    def excel(){
        def path = new File("d:/abc1.xls")
        try {
            /*Workbook book=Workbook.getWorkbook(path);//
            Sheet sheet=book.getSheet(0);   //获得第一个工作表对象
            def titles = []
            def recs = []
            for(int i=0;i<sheet.getRows();i++){
                def map = [:]
                breakA:
                for(int j=0;j<sheet.getColumns();j++){
                    def cell=sheet.getCell(j, i);  //获得单元格
                    def content = cell.contents
                    content = content?content.trim():''
                    if(i == 0){
                        titles << content
                    }else{
                        if (j == 0 && content == '320102'){
                              break breakA
                        }
                        map["${titles[j]}"] =content
                    }

                }
                if(map){
                    recs << map
                }
            }
            println recs*/
            def list = [[dqdm:'320121', ksh:'2320102000121', xm:'沈淑君', sfzh:'330302199211045249', jtdz:'南京市江宁区左邻右里5栋二单元504', yzbm:'211100', lxdh:'02552155923,15240249002', kjh:'120102090140'],
                    [dqdm:'320114', ksh:'12320102450461', xm:'马晨', sfzh:'32011419940426271X', jtdz:'南京市雨花开发区西寇村238号', yzbm:'210041', lxdh:'02584217486,13813378598', kjh:'120102060301']]
            def props = [font:'Kefa']
            def outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("中文名.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {

                sheet { //Default name for sheet
                    list.eachWithIndex {m,i->
                        def index = 0
                        if(i ==0 ){
                            m.each {k,v->
                                cell(index,0,k)
                                cell(index,1,v)
                                index++
                            }
                        }else{
                            m.each {k,v->
                                cell(index,i+1,v)
                                index++
                            }
                        }
                    }
                }
            }
            IOUtils.closeQuietly(outputStream)
        } catch (BiffException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        render('ok')
    }
}
