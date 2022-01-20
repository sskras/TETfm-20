BEGIN {
    MATCH_AT = 999999
}

{
    if (match ($0, /image::https:..asciinema/))
    {
        MATCH_AT = NR
        sub(/image::/, "")
        gsub(/^https:..|.svg|.link=.|..$/, " ")
        URL_TITLE = $1
        URL = $2
        printf("%s[%s]\n", URL, URL_TITLE)

      # gsub(/^.*https:..|..$/, "")
      # print
    }
    else
        print
      # ;
}


