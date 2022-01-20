# 2022-01-20 saukrs: naudoju taip:
#   $ cat LD3-ataskaita.adoc | awk -f remove-images-from-asciinema-URLs.awk > LD3-ataskaita-to-HTML.adoc

BEGIN {
    MATCH_AT = 999999
}

{
    if (match ($0, /image::https:..asciinema/))
    {
      # image::https://asciinema.org/a/462404.svg[link="https://asciinema.org/a/462404?autoplay=1"]
      #   =>
      # <script id="asciicast-462320" src="https://asciinema.org/a/462320.js" async></script>

        MATCH_AT = NR
        gsub(/^image::https:[^0-9]+|.svg/, " ")
        CAST_ID = $1
        URL = $2
        printf("+++\n")
        printf("<script id=\"asciicast-%s\" src=\"https://asciinema.org/a/%s.js\" async></script>\n", CAST_ID, CAST_ID)
        printf("+++\n")

      # gsub(/^.*https:..|..$/, "")
      # print
    }
    else
        print
      # ;
}


