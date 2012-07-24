package org.jruby.lexer;

import beaver.Symbol;
import beaver.Scanner;
import org.jruby.parser.JavaSignatureBeaverParser;
import org.jruby.parser.JavaSignatureBeaverParser.Terminals;

%%

%public
%class JavaSignatureBeaverLexer
%extends Scanner
%function nextToken
%type Symbol
%yylexthrow Scanner.Exception
%eofval{
          return new Symbol(Terminals.EOF, "end-of-file");
%eofval}
%standalone
%unicode
%line
%column
%{
    

  boolean stringResult = false;
  boolean characterResult = false;
  StringBuilder stringBuf = new StringBuilder();

  public Object value() {
    if (stringResult) {
        stringResult = false;
        String value = stringBuf.toString();
        stringBuf.setLength(0);
        return value;
    } else if (characterResult) {
        characterResult = false;
        String value = stringBuf.toString();
        if (stringBuf.length() != 1) throw new Error("Character not on char ("+ value +")");
        stringBuf.setLength(0);
        return value;
    }
    return yytext();
  }
  private Symbol newToken(short id)
	{
		return new Symbol(id, yyline + 1, yycolumn + 1, yylength());
	}

	private Symbol newToken(short id, Object value)
	{
		return new Symbol(id, yyline + 1, yycolumn + 1, yylength(), value);
	}
    public static JavaSignatureBeaverLexer create(java.io.InputStream stream) {
    return new JavaSignatureBeaverLexer(stream);
  }


%}

LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
Identifier     = [:jletter:] [:jletterdigit:]*
//Digit          = [0-9]
//HexDigit       = {Digit} | [a-f] | [A-F]
//UnicodeEscape  = "\\u" {HexDigit} {HexDigit} {HexDigit} {HexDigit}
//EscapedChar    = "\\" [nybrf\\'\"]
//NonEscapedChar = [^nybrf\\'\"]
//CharacterLiteral = "'" ({NonEscapedChar} | {EscapedChar} | {UnicodeEscape}) "'"
//StringLiteral  = "\"" ({NonEscapedChar} | {EscapedChar} | {UnicodeEscape})* "\""

%state CHARACTER
%state STRING

%%

<YYINITIAL> {
    // primitive types
    "boolean"       { return newToken(Terminals.BOOLEAN);      }
    "byte"          { return  newToken(Terminals.BYTE);         }
    "short"         { return  newToken(Terminals.SHORT);        }
    "int"           { return  newToken(Terminals.INT);          }
    "long"          { return  newToken(Terminals.LONG);         }
    "char"          { return  newToken(Terminals.CHAR);         }
    "float"         { return  newToken(Terminals.FLOAT);        }
    "double"        { return  newToken(Terminals.DOUBLE);       }
    "void"          { return  newToken(Terminals.VOID);         }

    // modifiers
    "public"        { return  newToken(Terminals.PUBLIC);       }
    "protected"     { return  newToken(Terminals.PROTECTED);   }
    "private"       { return  newToken(Terminals.PRIVATE);      }
    "static"        { return  newToken(Terminals.STATIC);       }
    "abstract"      { return  newToken(Terminals.ABSTRACT);     }
    "final"         { return  newToken(Terminals.FINAL);        }
    "native"        { return  newToken(Terminals.NATIVE);       }
    "synchronized"  { return  newToken(Terminals.SYNCHRONIZED); }
    "transient"     { return  newToken(Terminals.TRANSIENT);    }
    "volatile"      { return  newToken(Terminals.VOLATILE);     }
    "strictfp"      { return  newToken(Terminals.STRICTFP);     }

    "@"             { return newToken(Terminals.AT);           }
    "&"             { return newToken(Terminals.AND);          }
    "."             { return newToken(Terminals.DOT);          }
    ","             { return newToken(Terminals.COMMA);        }
    "\u2026"        { return newToken(Terminals.ELLIPSIS);     }
    "..."           { return newToken(Terminals.ELLIPSIS);     }
    "="             { return newToken(Terminals.EQUAL);        }
    "{"             { return newToken(Terminals.LCURLY);       }
    "}"             { return newToken(Terminals.RCURLY);       }
    "("             { return newToken(Terminals.LPAREN);       }
    ")"             { return newToken(Terminals.RPAREN);       }
    "["             { return newToken(Terminals.LBRACK);       }
    "]"             { return newToken(Terminals.RBRACK);       }
    "?"             { return newToken(Terminals.QUESTION);     }
    "<"             { return newToken(Terminals.LT);           }
    ">"             { return newToken(Terminals.GT);           }
    "throws"        { return newToken(Terminals.THROWS);       }
    "extends"       { return newToken(Terminals.EXTENDS);      }
    "super"         { return newToken(Terminals.SUPER);        }
    ">>"            { return newToken(Terminals.RSHIFT);       }
    ">>>"           { return newToken(Terminals.URSHIFT);      }

    {Identifier}    {  
                      return newToken(Terminals.IDENTIFIER, yytext());   }
    \"              { yybegin(STRING); } 
    \'              { yybegin(CHARACTER); } 
    {WhiteSpace}    { }
}

<CHARACTER> {
    \' { characterResult = true;
         yybegin(YYINITIAL);
         return newToken(Terminals.CHARACTER_LITERAL); 
       }
    .  { stringBuf.append(yytext()); }
}

<STRING> {
  \"                {
                     stringResult = true;
                     yybegin(YYINITIAL); 
                     return newToken(Terminals.STRING_LITERAL);
  }
  [^\n\r\"\\]+      { stringBuf.append( yytext() ); }
  \\t               { stringBuf.append('\t'); }
  \\n               { stringBuf.append('\n'); }
  \\r               { stringBuf.append('\r'); }
  \\\"              { stringBuf.append('\"'); }
  \\                { stringBuf.append('\\'); }
}

.|\n  { throw new Error("Invalid character ("+yytext()+")"); }
