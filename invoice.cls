}
}
    }
    }
    }
    \newcommand*{\hourrow}[3]{%
% Returns the total of counter
        \setcounter{subhours}{0}
		\newcommand{\subtotalNoStar}{
%  "Software"), to deal in the Software without restriction, including     %
% Counters for totaling up hours and dollars
% Formats inputed number with 2 digits after the decimal place
         \addtocounter{subcost}{1000 * \real{##2}}%
		}
		}
		}
\usepackage[letterpaper,hmargin=0.79in,vmargin=0.79in]{geometry}
%  permit persons to whom the Software is furnished to do so, subject to   %
    % Create a new row from title, unit quantity, unit rate, and unit name
		\newcommand{\subtotal}{
\newcommand*{\formatNumber}[1]{\FPround{\cost}{#1}{2}\cost} %
%  the following conditions:                                               %
        {\bf Subtotal} & & & {\bf \$\total{subcost}}
    \end{longtable}
         \@ifstar
    \hline\hline
\pagestyle{empty} % No page numbers
         ##1 & & \$\formatNumber{##2} & \$\FPmul{\cost}{##2}{1}\formatNumber{\cost}%
\usepackage{calc} % Counters for totaling hours and cost
         \subtotalNoStar%
%  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.         %
    \newcommand*{\unitrow}[4]{%
    \setlength\LTleft{0pt}
\newcommand*{\total}[1]{\FPdiv{\t}{\arabic{#1}}{1000}\formatNumber{\t}}
        \setcounter{subcost}{0}
        \setcounter{subcost}{0}
    \setlength\LTright{0pt}
         \addtocounter{cost}{1000 * \real{##2}}%
    \hline\hline\hline
%  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                   %
\usepackage{longtable}
%  The above copyright notice and this permission notice shall be          %
         \\
         \\
\newenvironment{invoiceTable}{
\linespread{1.5} % Line spacing
    % Create a new row from date and hours worked (use stored fee type and hourly rate)
\setlength{\doublerulesep}{\arrayrulewidth} % Double rules look like one thick one
    {\bf Balance Due} & & & {\bf \$\total{cost}} \\
    \textbf{#1}
%  a copy of this software and associated documentation files (the         %
}{
%  distribute, sublicense, and/or sell copies of the Software, and to      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
        {\bf Subtotal} & {\bf \total{subhours} hours} &  & {\bf \$\total{subcost}}
\usepackage[parfill]{parskip} % Do not indent paragraphs
    \begin{longtable}{@{\extracolsep{\fill}\hspace{\tabcolsep}} l r r r }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ProvidesClass{invoice}
\setcounter{hours}{0} \setcounter{subhours}{0} \setcounter{cost}{0} \setcounter{subcost}{0}
%  Copyright (c) 2011 Trey Hunner                                          %
%  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION  %
\usepackage{fp} % Fixed-point arithmetic
%  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION   %
%  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF      %
%  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,         %
%                                                                          %
%                                                                          %
%                                                                          %
%                                                                          %
\LoadClass[12pt]{article}
        \addtocounter{hours}{1000 * \real{##2}}%
%  included in all copies or substantial portions of the Software.         %
%  Permission is hereby granted, free of charge, to any person obtaining   %
\newcommand{\feetype}[1]{
    \hline
    \newcommand*{\feerow}[2]{%
		\newcommand{\subtotalStar}{
    % Create a new row from title and expense amount
         \hline
    \endhead
    \renewcommand{\tabcolsep}{0.8ex}
% Command for setting a default hourly rate
         \addtocounter{subcost}{1000 * \real{##2} * \real{##3}}%
% Create an invoice table
        \unitrow{##1}{##2}{##3}{hours}%
         \subtotalStar%
        \\*[1.5ex]
        \\*[1.5ex]
\newcounter{hours} \newcounter{subhours} \newcounter{cost} \newcounter{subcost}
    {\bf Description of Services} & \multicolumn{1}{c}{\bf Quantity} & \multicolumn{1}{c}{\bf Unit Price} & \multicolumn{1}{c}{\bf Amount} \\*
         \addtocounter{cost}{1000 * \real{##2} * \real{##3}}%
         ##1 & \formatNumber{##2} ##4 & \$\formatNumber{##3} & \$\FPmul{\cost}{##2}{##3}\formatNumber{\cost}%
    \\
%  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE  %
%  without limitation the rights to use, copy, modify, merge, publish,     %
















        \addtocounter{subhours}{1000 * \real{##2}}%
