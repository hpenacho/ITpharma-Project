﻿<%@ Page Title="" Language="C#" MasterPageFile="~/storeFrontMasterPage.Master" AutoEventWireup="true" CodeBehind="storeFront-405.aspx.cs" Inherits="PROJECTOFINAL.storeFront_405" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

              #notfound {
            position: relative;
            height: 100vh;
        }

            #notfound .notfound {
                position: absolute;
                left: 50%;
                top: 50%;
                -webkit-transform: translate(-50%, -50%);
                -ms-transform: translate(-50%, -50%);
                transform: translate(-50%, -50%);
            }

        .notfound {
            max-width: 920px;
            width: 100%;
            line-height: 1.4;
            text-align: center;
            padding-left: 15px;
            padding-right: 15px;
        }

            .notfound .notfound-404 {
                position: absolute;
                height: 100px;
                top: 0;
                left: 50%;
                -webkit-transform: translateX(-50%);
                -ms-transform: translateX(-50%);
                transform: translateX(-50%);
                z-index: -1;
            }

                .notfound .notfound-404 h1 {
                    font-family: 'Maven Pro', sans-serif;
                    color: #ececec;
                    font-weight: 900;
                    font-size: 276px;
                    margin: 0px;
                    position: absolute;
                    left: 50%;
                    top: 50%;
                    -webkit-transform: translate(-50%, -50%);
                    -ms-transform: translate(-50%, -50%);
                    transform: translate(-50%, -50%);
                }

            .notfound h2 {
                font-family: 'Maven Pro', sans-serif;
                font-size: 46px;
                color: #000;
                font-weight: 900;
                text-transform: uppercase;
                margin: 0px;
            }

            .notfound p {
                font-family: 'Maven Pro', sans-serif;
                font-size: 16px;
                color: #000;
                font-weight: 400;
                text-transform: uppercase;
                margin-top: 15px;
            }

            .notfound a {
                font-family: 'Maven Pro', sans-serif;
                font-size: 14px;
                text-decoration: none;
                text-transform: uppercase;
                background: #189cf0;
                display: inline-block;
                padding: 16px 38px;
                border: 2px solid transparent;
                border-radius: 40px;
                color: #fff;
                font-weight: 400;
                -webkit-transition: 0.2s all;
                transition: 0.2s all;
            }

                .notfound a:hover {
                    background-color: #fff;
                    border-color: #189cf0;
                    color: #189cf0;
                }

        @media only screen and (max-width: 480px) {
            .notfound .notfound-404 h1 {
                font-size: 162px;
            }

            .notfound h2 {
                font-size: 26px;
            }
        }



    </style>


</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container bg-white my-3">
        <div id="notfound">
            <div class="notfound">
                <div class="notfound-404">
                    <h1>405</h1>
                </div>
                <h2>We are sorry, something happened!</h2>
                <p>This page is currently unavailable, please try again later.</p>
                <a href="storeFront-index.aspx">Back To Homepage</a>
            </div>
        </div>
    </div>


</asp:Content>
