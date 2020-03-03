
#两种解决springboot 跨域问题的方法示例

##1.全局配置

    /**
     * 全局跨域处理
     * @author Boolean
     *
     */
    @Configuration
    public class CorsConfig {
        private CorsConfiguration buildConfig() {  
            CorsConfiguration corsConfiguration = new CorsConfiguration();  
            corsConfiguration.addAllowedOrigin("*"); // 1允许任何域名使用
            //corsConfiguration.addAllowedOrigin("http://www.test.com"); // 1允许特定域名使用
            corsConfiguration.addAllowedHeader("*"); // 2允许任何头
            corsConfiguration.addAllowedMethod("*"); // 3允许任何方法（post、get等） 
            return corsConfiguration;  
        }  
      
        @Bean  
        public CorsFilter corsFilter() {  
            UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();  
            source.registerCorsConfiguration("/**", buildConfig()); // 4  
            return new CorsFilter(source);  
        } 
    }
    
 ##2.注解
 
    方式更准确，但是相对来说较为麻烦。具体做法就是在每个需要跨域的接口上使用@CrossOrigin注解。
    @CrossOrigin(allowCredentials = "true", allowedHeaders = "*", origins = "*")
    allowCredentials(true)：允许跨域cookie等用户凭证传递（默认为false）
