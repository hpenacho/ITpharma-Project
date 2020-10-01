<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    
  
  <xsl:template match="/rss/channel">
 
    <div class="site-main-container">
      <!-- Start top-post Area -->
      <section class="top-post-area pt-10">
        <div class="container no-padding">
          <div class="row small-gutters justify-content-center">
            <div class="col-lg-8 top-post-left">
              <div class="feature-image-thumb relative shadow shadow-lg" style="border-radius:20px">
                <div class="overlay overlay-bg"></div>
                <img class="img-fluid" src="{item[1]/enclosure/@url}" alt="" />
              </div>
              <div class="top-post-details">
                <ul class="tags">
                  <li>
                    <a href="https://news.un.org/en/news/topic/health">
                      Health
                    </a>
                  </li>
                </ul>
                <a href="{item[1]/guid}">
                  <h3>

                    <xsl:value-of select="item[1]/title"/>

                  </h3>
                </a>
                <ul class="meta">
                  <li>
                    <a href="#">
                      <span class="lnr lnr-user"></span>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <span class="lnr lnr-calendar-full">



                      </span>
                      <p>
                        <xsl:value-of select="item[1]/pubDate"/>
                      </p>

                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <span class="lnr lnr-bubble"></span>
                    </a>
                  </li>
                </ul>
              </div>
            </div>
            
            <div class="col-lg-12">

            </div>
          </div>
        </div>
      </section>
      <!-- End top-post Area -->
      <!-- Start latest-post Area -->
      <section class="latest-post-area pb-120">
        <div class="container no-padding">
          <div class="row justify-content-center">
            <div class="col-lg-11 post-list">
              <!-- Start latest-post Area -->
              <div class="latest-post-wrap shadow shadow-sm text-center">
                <h4 class="cat-title rounded">Health Sector News</h4>
                <div class="single-latest-post row align-items-center">
                  <div class="col-lg-5 post-left">
                    <div class="feature-img relative rounded">
                      <div class="overlay overlay-bg rounded"></div>
                      <img class="img-fluid" src="{item[2]/enclosure/@url}" alt="" />
                    </div>
                    <ul class="tags">
                      <li>
                        <a href="https://news.un.org/en/news/topic/health">
                          Health
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="col-lg-7 post-right text-center">
                    <a href="{item[2]/guid}">
                      <span class="h4 text-decoration-none text-center">
                        <xsl:value-of select="item[2]/title"/>
                      </span>
                    </a>
                    <ul class="meta">
                      <li>
                        <a href="#">
                          <span class="lnr lnr-user"></span>
                        </a>
                      </li>
                      <li>
                        <a href="#">
                          <span class="lnr lnr-calendar-full"></span>
                          <p>
                            <xsl:value-of select="item[2]/pubDate"/>
                          </p>
                        </a>
                      </li>
                      <li>
                        <a href="#">
                          <span class="lnr lnr-bubble"></span>
                        </a>
                      </li>
                    </ul>
                    <p class="excert">
                      <p>
                        <xsl:value-of select="item[2]/description"/>
                      </p>
                    </p>
                  </div>
                </div>

                <hr></hr>
                
                <div class="single-latest-post row align-items-center">
                  <div class="col-lg-5 post-left">
                    <div class="feature-img relative rounded">
                      <div class="overlay overlay-bg"></div>
                      <img class="img-fluid" src="{item[3]/enclosure/@url}" alt="" />
                    </div>
                    <ul class="tags">
                      <li>
                        <a href="https://news.un.org/en/news/topic/health">
                          Health
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="col-lg-7 post-right text-center">
                    <a href="{item[3]/guid}">
                      <span class="h4 text-decoration-none text-center">
                        <xsl:value-of select="item[3]/title"/>
                      </span>
                    </a>
                    <ul class="meta">
                      <li>
                        <a href="#">
                          <span class="lnr lnr-user"></span>
                        </a>
                      </li>
                      <li>
                        <a href="#">
                          <span class="lnr lnr-calendar-full"></span>
                          <p>
                            <xsl:value-of select="item[3]/pubDate"/>
                          </p>
                        </a>
                      </li>
                      <li>
                        <a href="#">
                          <span class="lnr lnr-bubble"></span>
                        </a>
                      </li>
                    </ul>
                    <p>
                      <p>
                        <xsl:value-of select="item[3]/description"/>
                      </p>
                    </p>
                  </div>
                </div>
                <hr></hr>
                <div class="single-latest-post row align-items-center">
                  <div class="col-lg-5 post-left">
                    <div class="feature-img relative rounded">
                      <div class="overlay overlay-bg"></div>
                      <img class="img-fluid" src="{item[4]/enclosure/@url}" alt="" />
                    </div>
                    <ul class="tags">
                      <li>
                        <a href="https://news.un.org/en/news/topic/health">
                          Health
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="col-lg-7 post-right text-center">
                    <a href="{item[4]/guid}">
                      <span class="h4 text-decoration-none text-center">
                        <xsl:value-of select="item[4]/title"/>
                      </span>
                    </a>
                    <ul class="meta">
                      <li>
                        <a href="#">
                          <span class="lnr lnr-user"></span>
                        </a>
                      </li>
                      <li>
                        <a href="#">
                          <span class="lnr lnr-calendar-full"></span>
                          <p>
                            <xsl:value-of select="item[4]/pubDate"/>
                          </p>
                        </a>
                      </li>
                      <li>
                        <a href="#">
                          <span class="lnr lnr-bubble"></span>
                        </a>
                      </li>
                    </ul>
                    <p>
                      <p>
                        <xsl:value-of select="item[4]/description"/>
                      </p>
                    </p>
                  </div>
                </div>
                <hr></hr>
                <div class="single-latest-post row align-items-center">
                  <div class="col-lg-5 post-left">
                    <div class="feature-img relative rounded">
                      <div class="overlay overlay-bg"></div>
                      <img class="img-fluid" src="{item[5]/enclosure/@url}"  alt="" />
                    </div>
                    <ul class="tags">
                      <li>
                        <a href="https://news.un.org/en/news/topic/health">
                          Health
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="col-lg-7 post-right text-center">
                    <a href="{item[5]/guid}">
                      <span class="h4 text-decoration-none text-center">
                        <xsl:value-of select="item[5]/title"/>
                      </span>
                    </a>
                    <ul class="meta">
                      <li>
                        <a href="#">
                          <span class="lnr lnr-user"></span>
                        </a>
                      </li>
                      <li>
                        <a href="#">
                          <span class="lnr lnr-calendar-full"></span>
                          <p>
                            <xsl:value-of select="item[5]/pubDate"/>
                          </p>
                        </a>
                      </li>
                      <li>
                        <a href="#">
                          <span class="lnr lnr-bubble"></span>
                        </a>
                      </li>
                    </ul>
                    <p>
                      <p>
                        <xsl:value-of select="item[5]/description"/>
                      </p>
                    </p>
                  </div>
                </div>
              </div>
              <!-- End latest-post Area -->

              <!-- Start banner-ads Area -->

              <!-- End banner-ads Area -->
              <!-- Start popular-post Area -->

              <!-- End popular-post Area -->
              
            </div>

          </div>
        </div>
      </section>
      <!-- End latest-post Area -->
    </div>
  
    </xsl:template>
</xsl:stylesheet>
