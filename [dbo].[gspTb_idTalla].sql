﻿USE [bapEmpresa02]
GO
/****** Object:  StoredProcedure [dbo].[gspTb_idTalla]    Script Date: 30/09/2015 08:46:22 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC gspTb_idTalla
 'RQ'
,'0001'
,'0000000001' 
,NULL
,'REQ'

EXEC gspTb_idTalla
 NULL
,NULL
,NULL
,'0A29'
,'IDA'
*/
ALTER PROCEDURE [dbo].[gspTb_idTalla]
(
	 @tipreq CHAR(2) =NULL--'RQ'
	,@serreq CHAR(4) =NULL--'0001'
	,@numreq CHAR(10)=NULL--'0000000004'
	,@articid CHAR(4)=NULL
	,@Idx	  CHAR(3)=NULL
)
AS
BEGIN
	IF (@Idx='REQ')/*BUSQUEDA POR ID DE REQUERIMIENTO*/
	BEGIN
		select distinct left(ta.tallaid,2)tallaid 
		from tb_pp_ordenprodcab opc
			inner join tb_pt_articulo art on
				opc.articid=art.articid 
			inner join tb_pt_talla ta on
				left(ta.tallaid,2)=art.tallaid
			inner join tb_pp_reqproddet rqd on 
					rqd.tipop=opc.tipop 
				AND rqd.serop=opc.serop 
				AND rqd.numop=opc.numop
		where
				(rqd.tipreq =@tipreq
			AND rqd.serreq =@serreq
			AND rqd.numreq =@numreq)
	END

	IF (@Idx='IDA')/*BUSQUEDA POR ID DE TALLA*/
	BEGIN
		select distinct left(ar.tallaid,2)tallaid
		from tb_pt_articulo ar	
			inner join tb_pt_talla ta on
			ar.tallaid=ta.tallaid	
		where 
			ar.articid=@articid
	END
		 
END







