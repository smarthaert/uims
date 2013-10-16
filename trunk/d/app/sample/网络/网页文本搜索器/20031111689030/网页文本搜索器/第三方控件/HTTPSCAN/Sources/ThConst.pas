{(((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
(                              THttpScan v4.02                               )
(                       Copyright (c) 2001 Michel Fornengo                   )
(                             All rights reserved.                           )
(                                                                            )
( home page:     http://www.delphicity.com                                   )
( contacts:      contact@delphicity.com                                      )
( support:       support@delphicity.com                                      )
((((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
( Description: commonly used constants                                       )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit ThConst;

interface

const

    MAXHISTORY = 20;
    TIMERINTERVAL = 200;

    IDHREF =     chr(4);
    IDVALUE =    chr(5);
    IDSRC =      chr(6);
    IDBASEHREF = chr(7);
    IDLOCATION = chr(12);

    IDAREA = chr (14);
    IDENDAREA = chr (16);
    IDPAIRAREA = chr(15);

    ODOA = chr(13) + chr(10);
    DEFAULTKEYWORDSLIMITER = '';
    DEFAULTTYPEFILTER = 'gif';
    DEFAULTKEYWORDSFILTER = 'track' + ODOA + 'hitbox' + ODOA + 'referer' + ODOA + 'stat' + ODOA + 'count' + ODOA;
    DEFAULTHTMLEXTENSIONS = 'htm'   +ODOA+
                            'html'  +ODOA+
                            'php'   +ODOA+
                            'php3'  +ODOA+
                            'php4'  +ODOA+
                            'php5'  +ODOA+
                            'pl'    +ODOA+
                            'asp'   +ODOA+
                            'cgi'   +ODOA+
                            'phtm'  +ODOA+
                            'phtml' +ODOA+
                            'shtm'  +ODOA+
                            'shtml';

    DEFAULT_AGENT = 'Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)';
    HTTPGRAB_FILETYPES = 'gif' +ODOA+ 'jpeg' +ODOA+ 'mp3' +ODOA+ 'mpg' +ODOA+ 'mpeg' +ODOA+ 'ra' +ODOA+ 'mov' +ODOA+ 'jpg';
    THUMBGRABBER_FILETYPES = 'gif' + ODOA + 'jpeg' + ODOA + 'jpg' + ODOA + 'mpeg' + ODOA + 'mpg' + ODOA + 'avi';

    DOWNLOAD_SUBPATH = 'Download\';

implementation

end.
