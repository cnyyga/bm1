package bm

import com.baoming.Preppy
import com.baoming.ProtocolCode
import groovy.transform.Synchronized
import org.apache.commons.lang.time.DateUtils

class PreppyService {

    @Synchronized
    def buildProtocolCode() {
        def cal = Calendar.instance
        def year = cal.get(Calendar.YEAR)
        def pc = ProtocolCode.createCriteria().get {

            eq('year', year)
            projections {
                max('num')
            }
        }

        if(!pc)   {
            pc = 0
        }
        pc = pc + 1
        new ProtocolCode(year:year,num: pc).save(flush: true)

        return "${year}${cover(pc)}"
    }

    def cover (def num) {
         if(!num) {
             return "0001";
         }
        num = num as String
        def len = num.length();
        (0..(3-len)).each {
            num = "0${num}"
        }
        return num
    }

    def generateCode(Preppy preppy){
        if(preppy.reviewStatus == Preppy.ReviewStatus.NO_AUDIT ||preppy.reviewStatus == Preppy.ReviewStatus.NO_PASS ){
            return
        }
        def c = '';
        if(preppy.reviewStatus == Preppy.ReviewStatus.GJSZZ){
            c = "G"
        }else if(preppy.reviewStatus == Preppy.ReviewStatus.JSZZ){
            c = "Z"
        }else if(preppy.reviewStatus == Preppy.ReviewStatus.JSPG){
            c = "P"
        }
        def d = new Date().clearTime()
        d = DateUtils.truncate(d,Calendar.YEAR)
        def p = Preppy.findByDateCreatedGreaterThanEqualsAndCodeIsNotNull(d,[sort:'code',order:'desc'])
        def code = "001"
        if(p){
            if(p.code){
                code = p.code as int
                code = code + 1
                code = makeCode(code)
            }
        }
        def p1 = Preppy.findByReviewStatusAndDateCreatedGreaterThanEqualsAndCsCodeIsNotNull(preppy.reviewStatus,d,[sort:'csCode',order:'desc'])
        if(!p1){
            return [code,"${c}001"]
        }
        def csCode = p1.csCode
        if(csCode){
            csCode = csCode.substring(1)
            csCode = csCode as int
            csCode = csCode + 1
            csCode = makeCode(csCode)
        }else{
            csCode = "001"
        }

        return [code,"${c}${csCode}"]
    }

    def makeCode(def code){
        int len = 3 - "${code}".length()
        def str = ""
        for(int i=0;i<len;i++){
            str +="0"
        }
        return str+"${code}";
    }
}
