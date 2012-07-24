/*
 ***** BEGIN LICENSE BLOCK *****
 * Version: CPL 1.0/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Common Public
 * License Version 1.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.eclipse.org/legal/cpl-v10.html
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * Copyright (C) 2001-2002 Jan Arne Petersen <jpetersen@uni-bonn.de>
 * Copyright (C) 2004-2005 Thomas E Enebo <enebo@acm.org>
 * 
 * Alternatively, the contents of this file may be used under the terms of
 * either of the GNU General Public License Version 2 or later (the "GPL"),
 * or the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the CPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the CPL, the GPL or the LGPL.
 ***** END LICENSE BLOCK *****/
package org.jruby.parser;

public interface Tokens {
    int yyErrorCode = DefaultRubyBeaverParser.yyErrorCode;
    int kCLASS      = DefaultRubyBeaverParser.kCLASS;
    int kMODULE     = DefaultRubyBeaverParser.kMODULE;
    int kDEF        = DefaultRubyBeaverParser.kDEF;
    int kUNDEF      = DefaultRubyBeaverParser.kUNDEF;
    int kBEGIN      = DefaultRubyBeaverParser.kBEGIN;
    int kRESCUE     = DefaultRubyBeaverParser.kRESCUE;
    int kENSURE     = DefaultRubyBeaverParser.kENSURE;
    int kEND        = DefaultRubyBeaverParser.kEND;
    int kIF         = DefaultRubyBeaverParser.kIF;
    int kUNLESS     = DefaultRubyBeaverParser.kUNLESS;
    int kTHEN       = DefaultRubyBeaverParser.kTHEN;
    int kELSIF      = DefaultRubyBeaverParser.kELSIF;
    int kELSE       = DefaultRubyBeaverParser.kELSE;
    int kCASE       = DefaultRubyBeaverParser.kCASE;
    int kWHEN       = DefaultRubyBeaverParser.kWHEN;
    int kWHILE      = DefaultRubyBeaverParser.kWHILE;
    int kUNTIL      = DefaultRubyBeaverParser.kUNTIL;
    int kFOR        = DefaultRubyBeaverParser.kFOR;
    int kBREAK      = DefaultRubyBeaverParser.kBREAK;
    int kNEXT       = DefaultRubyBeaverParser.kNEXT;
    int kREDO       = DefaultRubyBeaverParser.kREDO;
    int kRETRY      = DefaultRubyBeaverParser.kRETRY;
    int kIN         = DefaultRubyBeaverParser.kIN;
    int kDO         = DefaultRubyBeaverParser.kDO;
    int kDO_COND    = DefaultRubyBeaverParser.kDO_COND;
    int kDO_BLOCK   = DefaultRubyBeaverParser.kDO_BLOCK;
    int kRETURN     = DefaultRubyBeaverParser.kRETURN;
    int kYIELD      = DefaultRubyBeaverParser.kYIELD;
    int kSUPER      = DefaultRubyBeaverParser.kSUPER;
    int kSELF       = DefaultRubyBeaverParser.kSELF;
    int kNIL        = DefaultRubyBeaverParser.kNIL;
    int kTRUE       = DefaultRubyBeaverParser.kTRUE;
    int kFALSE      = DefaultRubyBeaverParser.kFALSE;
    int kAND        = DefaultRubyBeaverParser.kAND;
    int kOR         = DefaultRubyBeaverParser.kOR;
    int kNOT        = DefaultRubyBeaverParser.kNOT;
    int kIF_MOD     = DefaultRubyBeaverParser.kIF_MOD;
    int kUNLESS_MOD = DefaultRubyBeaverParser.kUNLESS_MOD;
    int kWHILE_MOD  = DefaultRubyBeaverParser.kWHILE_MOD;
    int kUNTIL_MOD  = DefaultRubyBeaverParser.kUNTIL_MOD;
    int kRESCUE_MOD = DefaultRubyBeaverParser.kRESCUE_MOD;
    int kALIAS      = DefaultRubyBeaverParser.kALIAS;
    int kDEFINED    = DefaultRubyBeaverParser.kDEFINED;
    int klBEGIN     = DefaultRubyBeaverParser.klBEGIN;
    int klEND       = DefaultRubyBeaverParser.klEND;
    int k__LINE__   = DefaultRubyBeaverParser.k__LINE__;
    int k__FILE__   = DefaultRubyBeaverParser.k__FILE__;
    int k__ENCODING__ = DefaultRubyBeaverParser.k__ENCODING__;
    int kDO_LAMBDA = DefaultRubyBeaverParser.kDO_LAMBDA;

    int tIDENTIFIER = DefaultRubyBeaverParser.tIDENTIFIER;
    int tFID        = DefaultRubyBeaverParser.tFID;
    int tGVAR       = DefaultRubyBeaverParser.tGVAR;
    int tIVAR       = DefaultRubyBeaverParser.tIVAR;
    int tCONSTANT   = DefaultRubyBeaverParser.tCONSTANT;
    int tCVAR       = DefaultRubyBeaverParser.tCVAR;
    int tINTEGER    = DefaultRubyBeaverParser.tINTEGER;
    int tFLOAT      = DefaultRubyBeaverParser.tFLOAT;
    int tSTRING_CONTENT     = DefaultRubyBeaverParser.tSTRING_CONTENT;
    int tSTRING_BEG = DefaultRubyBeaverParser.tSTRING_BEG;
    int tSTRING_END = DefaultRubyBeaverParser.tSTRING_END;
    int tSTRING_DBEG= DefaultRubyBeaverParser.tSTRING_DBEG;
    int tSTRING_DVAR= DefaultRubyBeaverParser.tSTRING_DVAR;
    int tXSTRING_BEG= DefaultRubyBeaverParser.tXSTRING_BEG;
    int tREGEXP_BEG = DefaultRubyBeaverParser.tREGEXP_BEG;
    int tREGEXP_END = DefaultRubyBeaverParser.tREGEXP_END;
    int tWORDS_BEG      = DefaultRubyBeaverParser.tWORDS_BEG;
    int tQWORDS_BEG      = DefaultRubyBeaverParser.tQWORDS_BEG;
    int tBACK_REF   = DefaultRubyBeaverParser.tBACK_REF;
    int tBACK_REF2  = DefaultRubyBeaverParser.tBACK_REF2;
    int tNTH_REF    = DefaultRubyBeaverParser.tNTH_REF;

    int tUPLUS      = DefaultRubyBeaverParser.tUPLUS;
    int tUMINUS     = DefaultRubyBeaverParser.tUMINUS;
    int tUMINUS_NUM     = DefaultRubyBeaverParser.tUMINUS_NUM;
    int tPOW        = DefaultRubyBeaverParser.tPOW;
    int tCMP        = DefaultRubyBeaverParser.tCMP;
    int tEQ         = DefaultRubyBeaverParser.tEQ;
    int tEQQ        = DefaultRubyBeaverParser.tEQQ;
    int tNEQ        = DefaultRubyBeaverParser.tNEQ;
    int tGEQ        = DefaultRubyBeaverParser.tGEQ;
    int tLEQ        = DefaultRubyBeaverParser.tLEQ;
    int tANDOP      = DefaultRubyBeaverParser.tANDOP;
    int tOROP       = DefaultRubyBeaverParser.tOROP;
    int tMATCH      = DefaultRubyBeaverParser.tMATCH;
    int tNMATCH     = DefaultRubyBeaverParser.tNMATCH;
    int tDOT        = DefaultRubyBeaverParser.tDOT;
    int tDOT2       = DefaultRubyBeaverParser.tDOT2;
    int tDOT3       = DefaultRubyBeaverParser.tDOT3;
    int tAREF       = DefaultRubyBeaverParser.tAREF;
    int tASET       = DefaultRubyBeaverParser.tASET;
    int tLSHFT      = DefaultRubyBeaverParser.tLSHFT;
    int tRSHFT      = DefaultRubyBeaverParser.tRSHFT;
    int tCOLON2     = DefaultRubyBeaverParser.tCOLON2;

    int tCOLON3     = DefaultRubyBeaverParser.tCOLON3;
    int tOP_ASGN    = DefaultRubyBeaverParser.tOP_ASGN;
    int tASSOC      = DefaultRubyBeaverParser.tASSOC;
    int tLPAREN     = DefaultRubyBeaverParser.tLPAREN;
    int tLPAREN2     = DefaultRubyBeaverParser.tLPAREN2;
    int tRPAREN     = DefaultRubyBeaverParser.tRPAREN;
    int tLPAREN_ARG = DefaultRubyBeaverParser.tLPAREN_ARG;
    int tLBRACK     = DefaultRubyBeaverParser.tLBRACK;
    int tRBRACK     = DefaultRubyBeaverParser.tRBRACK;
    int tLBRACE     = DefaultRubyBeaverParser.tLBRACE;
    int tLBRACE_ARG     = DefaultRubyBeaverParser.tLBRACE_ARG;
    int tSTAR       = DefaultRubyBeaverParser.tSTAR;
    int tSTAR2      = DefaultRubyBeaverParser.tSTAR2;
    int tAMPER      = DefaultRubyBeaverParser.tAMPER;
    int tAMPER2     = DefaultRubyBeaverParser.tAMPER2;
    int tSYMBEG     = DefaultRubyBeaverParser.tSYMBEG;
    int tTILDE      = DefaultRubyBeaverParser.tTILDE;
    int tPERCENT    = DefaultRubyBeaverParser.tPERCENT;
    int tDIVIDE     = DefaultRubyBeaverParser.tDIVIDE;
    int tPLUS       = DefaultRubyBeaverParser.tPLUS;
    int tMINUS       = DefaultRubyBeaverParser.tMINUS;
    int tLT         = DefaultRubyBeaverParser.tLT;
    int tGT         = DefaultRubyBeaverParser.tGT;
    int tCARET      = DefaultRubyBeaverParser.tCARET;
    int tBANG       = DefaultRubyBeaverParser.tBANG;
    int tLCURLY     = DefaultRubyBeaverParser.tLCURLY;
    int tRCURLY     = DefaultRubyBeaverParser.tRCURLY;
    int tPIPE       = DefaultRubyBeaverParser.tPIPE;
    int tLAMBDA     = DefaultRubyBeaverParser.tLAMBDA;
    int tLAMBEG     = DefaultRubyBeaverParser.tLAMBEG;
    int tLABEL      = DefaultRubyBeaverParser.tLABEL;
    int tQUESTION   = DefaultRubyBeaverParser.tQUESTION;
    int tASSIGNMENT = DefaultRubyBeaverParser.tASSIGNMENT;
    int COMMA       = DefaultRubyBeaverParser.COMMA;
    int tLSQ        = DefaultRubyBeaverParser.tLSQ;
    int SEMICOLON   = DefaultRubyBeaverParser.SEMICOLON;
    int NL = DefaultRubyBeaverParser.NL;
    int tSPACE = DefaultRubyBeaverParser.tSPACE;
    String[] operators = {"+@", "-@", "**", "<=>", "==", "===", "!=", ">=", "<=", "&&",
                          "||", "=~", "!~", "..", "...", "[]", "[]=", "<<", ">>", "::"};
}
