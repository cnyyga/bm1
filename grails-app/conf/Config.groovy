import com.octo.captcha.service.multitype.GenericManageableCaptchaService
import com.octo.captcha.engine.GenericCaptchaEngine
import com.octo.captcha.image.gimpy.GimpyFactory
import com.octo.captcha.component.word.wordgenerator.RandomWordGenerator
import com.octo.captcha.component.image.wordtoimage.ComposedWordToImage
import com.octo.captcha.component.image.fontgenerator.RandomFontGenerator
import java.awt.Font
import com.octo.captcha.component.image.backgroundgenerator.GradientBackgroundGenerator
import com.octo.captcha.component.image.color.SingleColorGenerator
import java.awt.Color
import com.octo.captcha.component.image.textpaster.NonLinearTextPaster

// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = true

grails.cache.enabled=true

environments {
    development {
        grails.logging.jul.usebridge = true
        baoming.image.hostname = "/v0"
        baoming.image.storage.path = "D:\\v0"
    }
    production {
        baoming.image.hostname = "/v0"
        baoming.image.storage.path = "D:\\v0"
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}
    appenders {
        console name: "stdout",
                layout: pattern(conversionPattern: "%d{HH:mm:ss} %l %n[%5p] %m%n")
        appender new org.apache.log4j.DailyRollingFileAppender(name: "dailyAppender",
                layout: pattern(conversionPattern: '%d{HH:mm:ss} %l %n[%5p] %m%n'), fileName: "/var/logs/bm.log", datePattern: "yyyy-MM-dd")

    }

    root {
        error 'dailyAppender', 'stdout'
        additivity = true
    }

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

grails.plugins.springsecurity.logout.afterLogoutUrl = '/logout/dispatch'
grails.plugins.springsecurity.dao.reflectionSaltSourceProperty = 'username'
// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'com.baoming.account.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'com.baoming.account.UserRole'
grails.plugins.springsecurity.authority.className = 'com.baoming.account.Role'
grails.plugins.springsecurity.requestMap.className = 'com.baoming.account.Requestmap'
grails.plugins.springsecurity.securityConfigType = 'InterceptUrlMap'
grails.plugins.springsecurity.interceptUrlMap = [
        '/': ['ROLE_ADMIN','ROLE_TEACHER','ROLE_FINANCE'],
        '/home/**': ['ROLE_ADMIN','ROLE_TEACHER','ROLE_FINANCE'],
        '/student/imp/**': ['ROLE_ADMIN'],
        '/student/saveImp/**': ['ROLE_ADMIN'],
        '/student/edit/**': ['ROLE_ADMIN','ROLE_FINANCE'],
        '/preppy/**': ['ROLE_ADMIN','ROLE_FINANCE','ROLE_TEACHER'],
        '/medium/**': ['ROLE_ADMIN','ROLE_FINANCE','ROLE_TEACHER'],
        '/student/createNew/**': ['ROLE_ADMIN','ROLE_TEACHER','ROLE_FINANCE'],
        '/student/saveNew/**': ['ROLE_ADMIN','ROLE_TEACHER','ROLE_FINANCE'],
        '/student/delete/**': ['ROLE_ADMIN','ROLE_FINANCE'],
        '/student/create/**': ['ROLE_ADMIN','ROLE_FINANCE'],
        '/student/save/**': ['ROLE_ADMIN','ROLE_FINANCE'],
        '/student/update/**': ['ROLE_ADMIN','ROLE_FINANCE'],
        '/student/**': ['ROLE_ADMIN','ROLE_TEACHER','ROLE_FINANCE'],
        '/profile/rePassword/**': ['IS_AUTHENTICATED_FULLY'],
        '/profile/saveRePassword/**': ['IS_AUTHENTICATED_FULLY'],
        '/profile/**': ['ROLE_STUDENT'],
        '/department/**': ['ROLE_ADMIN'],
        '/admin/**': ['ROLE_ADMIN'],
        '/finance/**': ['ROLE_ADMIN'],
        '/teacher/**': ['ROLE_ADMIN'],
        '/nation/**': ['ROLE_ADMIN'],
        '/plan/**': ['ROLE_ADMIN'],
        '/mediumPlan/getPlans/**': ['ROLE_ADMIN','ROLE_FINANCE','ROLE_TEACHER'],
        '/preppyPlan/getPlans/**': ['ROLE_ADMIN','ROLE_FINANCE','ROLE_TEACHER'],
        '/mediumPlan/**': ['ROLE_ADMIN'],
        '/preppyPlan/getPlans1/**': ['IS_AUTHENTICATED_FULLY'],
        '/preppyPlan/**': ['ROLE_ADMIN','ROLE_TEACHER'],
        '/material/**': ['ROLE_ADMIN'],
        '/welcome/**': ['ROLE_ADMIN'],
        '/studentType/**': ['ROLE_ADMIN'],
        '/politicalStatus/**': ['ROLE_ADMIN'],
        '/province/**': ['ROLE_ADMIN'],
        '/middleSchool/**': ['ROLE_ADMIN'],
        '/statistics/**': ['ROLE_ADMIN'],
        '/comparison/**': ['ROLE_ADMIN','ROLE_FINANCE'],
        '/download/records/**': ['ROLE_ADMIN'],
        '/download/**': ['ROLE_ADMIN','ROLE_TEACHER'],
        '/reg/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
        '/login/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
        '/logout/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
        '/stu/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
        '/workPlan/**': ['ROLE_ADMIN','ROLE_FINANCE','ROLE_TEACHER'],
]

grails.plugins.springsecurity.successHandler.defaultTargetUrl = '/login/dispatch'

jcaptchas {
    Random random = new Random(new Date().getTime());
    imageCaptcha = new GenericManageableCaptchaService(
            new GenericCaptchaEngine(
                    new GimpyFactory(
                            //随机字符范围
                            new RandomWordGenerator(
                                    "abcdefghijklmnopqrstuvwxyz1234567890"
                            ),
                            new ComposedWordToImage(
                                    //字体
                                    new RandomFontGenerator(
                                            20, // min font size
                                            30, // max font size
                                            [new Font("Arial", 0, 10)] as Font[]
                                    ),
                                    //图片背景
                                    new GradientBackgroundGenerator(
                                            100, // width
                                            35, // height
                                            new SingleColorGenerator(new Color(255, 255, 255)),
                                            new SingleColorGenerator(new Color(255, 255, 255))
                                    ),
                                    //字符颜色个数限制
                                    new NonLinearTextPaster(
                                            4, // minimal length of text
                                            4, // maximal length of text
                                            new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255))
                                    )
                            )
                    )
            ),
            180, // minGuarantedStorageDelayInSeconds
            180000 // maxCaptchaStoreSize
    )
}
// Uncomment and edit the following lines to start using Grails encoding & escaping improvements

/* remove this line 
// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside null
                scriptlet = 'none' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        filteringCodecForContentType {
            //'text/html' = 'html'
        }
    }
}
remove this line */
