# 2022-01-20 saukrs: naudoju taip:
#   $ cat LD3-ataskaita.adoc | awk -f remove-images-from-asciinema-URLs.awk > LD3-ataskaita-to-HTML.adoc

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


