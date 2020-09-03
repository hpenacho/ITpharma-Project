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
                    <a href="#">
                      <xsl:value-of select="item[1]/category"/>
                    </a>
                  </li>
                </ul>
                <a href="image-post.html">
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
            <div class="col-lg-8 post-list">
              <!-- Start latest-post Area -->
              <div class="latest-post-wrap shadow shadow-sm" style="border-radius:20px;">
                <h4 class="cat-title">Noticias</h4>
                <div class="single-latest-post row align-items-center">
                  <div class="col-lg-5 post-left">
                    <div class="feature-img relative">
                      <div class="overlay overlay-bg"></div>
                      <img class="img-fluid" src="{item[4]/enclosure/@url}" alt="" />
                    </div>
                    <ul class="tags">
                      <li>
                        <a href="#">
                          <xsl:value-of select="item[4]/category"/>
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="col-lg-7 post-right">
                    <a href="image-post.html">
                      <h4>
                        <xsl:value-of select="item[4]/title"/>
                      </h4>
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
                    <p class="excert">
                      <p>
                        <xsl:value-of select="item[4]/description"/>
                      </p>
                    </p>
                  </div>
                </div>
                <div class="single-latest-post row align-items-center">
                  <div class="col-lg-5 post-left">
                    <div class="feature-img relative">
                      <div class="overlay overlay-bg"></div>
                      <img class="img-fluid" src="{item[5]/enclosure/@url}" alt="" />
                    </div>
                    <ul class="tags">
                      <li>
                        <a href="#">
                          <xsl:value-of select="item[5]/category"/>
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="col-lg-7 post-right">
                    <a href="image-post.html">
                      <h4>
                        <xsl:value-of select="item[5]/title"/>
                      </h4>
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
                <div class="single-latest-post row align-items-center">
                  <div class="col-lg-5 post-left">
                    <div class="feature-img relative">
                      <div class="overlay overlay-bg"></div>
                      <img class="img-fluid" src="{item[6]/enclosure/@url}" alt="" />
                    </div>
                    <ul class="tags">
                      <li>
                        <a href="#">
                          <xsl:value-of select="item[6]/category"/>
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="col-lg-7 post-right">
                    <a href="image-post.html">
                      <h4>
                        <xsl:value-of select="item[6]/title"/>
                      </h4>
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
                            <xsl:value-of select="item[6]/pubDate"/>
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
                        <xsl:value-of select="item[6]/description"/>
                      </p>
                    </p>
                  </div>
                </div>
                <div class="single-latest-post row align-items-center">
                  <div class="col-lg-5 post-left">
                    <div class="feature-img relative">
                      <div class="overlay overlay-bg"></div>
                      <img class="img-fluid" src="{item[7]/enclosure/@url}" alt="" />
                    </div>
                    <ul class="tags">
                      <li>
                        <a href="#">
                          <xsl:value-of select="item[7]/category"/>
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="col-lg-7 post-right">
                    <a href="image-post.html">
                      <h4>
                        <xsl:value-of select="item[7]/title"/>
                      </h4>
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
                            <xsl:value-of select="item[7]/pubDate"/>
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
                        <xsl:value-of select="item[7]/description"/>
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
