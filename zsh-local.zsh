export _dc="/Users/gonzalo/www/dragoncity"
alias _dc="cd $_dc"

export _dv="/Users/gonzalo/www/dragoncity/vendor/socialpoint"
alias _dv="cd $_dv"
export __v="vendor/socialpoint"
alias __v="cd $__dv"

export _b="/Users/gonzalo/www/dragoncity/vendor/socialpoint/sp-platform-base"
alias _b="cd $_b"
export __b="vendor/socialpoint/sp-platform-base"
alias __b="cd $__b"

export _dcc="/Users/gonzalo/www/dragoncity/vendor/socialpoint/social-dragons-config"
alias _dcc="cd $_dcc"
export __dcc="vendor/socialpoint/social-dragons-config"
alias __dcc="cd $__dcc"

export _d="/Users/gonzalo/www/dragoncity/vendor/socialpoint/social-dragons-bundle/SP/Bundle/SocialDragonsBundle"
alias _d="cd $_d"
export __d="vendor/socialpoint/social-dragons-bundle/SP/Bundle/SocialDragonsBundle"
alias __d="cd $__d"

export _fe="/Users/gonzalo/www/dragoncity/vendor/socialpoint/frontend-bundle/SP/Bundle/FrontendBundle"
alias _fe="cd $_fe"
export __fe="vendor/socialpoint/frontend-bundle/SP/Bundle/FrontendBundle"
alias __fe="cd $__fe"

export _t="/Users/gonzalo/www/dragoncity/vendor/socialpoint/toolbox-bundle/SP/Bundle/ToolboxBundle"
alias _t="cd $_t"
export __t="vendor/socialpoint/toolbox-bundle/SP/Bundle/ToolboxBundle"
alias __t="cd $__t"

export _gg="/Users/gonzalo/www/dragoncity/vendor/socialpoint/game-config-bundle/SP/Bundle/GameConfigBundle"
alias _gg="cd $_gg"
export __gg="vendor/socialpoint/game-config-bundle/SP/Bundle/GameConfigBundle"
alias __gg="cd $__gg"

export _fa="/Users/gonzalo/www/dragoncity/vendor/socialpoint/fanpage-bundle/SP/Bundle/FanPageBundle"
alias _fa="cd $_fa"
export __fa="vendor/socialpoint/fanpage-bundle/SP/Bundle/FanPageBundle"
alias __fa="cd $__fa"

export _p="/Users/gonzalo/www/dragoncity/vendor/socialpoint/payment-bundle/SP/Bundle/PaymentBundle"
alias _p="cd $_p"
export __p="vendor/socialpoint/payment-bundle/SP/Bundle/PaymentBundle"
alias __p="cd $__p"

export _m="/Users/gonzalo/www/monstercity/vendor/socialpoint/social-monsters-bundle/SP/Bundle/SocialMonstersBundle"
alias _m="cd $_m"
export __m="/vendor/socialpoint/social-monsters-bundle/SP/Bundle/SocialMonstersBundle"
alias __m="cd $__m"

export _bm="/Users/gonzalo/www/monstercity/vendor/socialpoint/sp-platform-base"
alias _bm="cd $_bm"
export __bm="/vendor/socialpoint/sp-platform-base"
alias __bm="cd $__bm"

export _da="/Users/gonzalo/www/dragoncity/vendor/socialpoint/analytics-bundle/SP/Bundle/AnalyticsBundle"
alias _da="cd $_da"
export __da="vendor/socialpoint/analytics-bundle/SP/Bundle/AnalyticsBundle"
alias __da="cd $__da"

export _dm="/Users/gonzalo/www/monstercity/vendor/socialpoint/social-dragons-bundle/SP/Bundle/SocialDragonsBundle"
alias _dm="cd $_dm"
export __dm="/vendor/socialpoint/social-dragons-bundle/SP/Bundle/SocialDragonsBundle"
alias __dm="cd $__dm"

# ----

export _mc="/Users/gonzalo/www/monstercity"
alias _mc="cd $_mc"
export _mv="/Users/gonzalo/www/monstercity/vendor/socialpoint"
alias _mv="cd $_mv"

export _sy="/Users/gonzalo/Development/socialpoint/sp-systems"
alias _sy="cd $_sy"
export _tt="/Users/gonzalo/Development/socialpoint/sp-systems/utils/src/SP/Bundle/TranslationsBundle/Command"
alias _tt="cd $_tt"

export _db="/Users/gonzalo/www/darkbattles"
alias _db="cd $_db"

alias __dc="ls -l ~/www | grep 'dragoncity ' | awk -F '-> ' '{print \$2}'"

export _dc1="~/Development/socialpoint/sp-platform-dragoncity-1"
alias _dc1="cd $_dc1"
alias __dc1="cd ~/www && rm dragoncity && ln -s $_dc1 dragoncity && cd - && __dc"

export _dc2="~/Development/socialpoint/sp-platform-dragoncity-2"
alias _dc2="cd $_dc2"
alias __dc2="cd ~/www && rm dragoncity && ln -s $_dc2 dragoncity && cd - && __dc"

export _dc3="~/Development/socialpoint/sp-platform-dragoncity-3"
alias _dc3="cd $_dc3"
alias __dc3="cd ~/www && rm dragoncity && ln -s $_dc3 dragoncity && cd - && __dc"

export _dc4="~/Development/socialpoint/sp-platform-dragoncity-4"
alias _dc4="cd $_dc4"
alias __dc4="cd ~/www && rm dragoncity && ln -s $_dc4 dragoncity && cd - && __dc"

function chpwd2() {
    # define env vars
    SPPATH="/Users/gonzalo/Development/socialpoint"
    SPGIT="github-sp.com"
    SPUSER="Gonzalo Serrano"
    SPMAIL="gonzalo.serrano@socialpoint.es"
    # execute normal "cd"
    emulate -L zsh
    # if we are in the SP dev dir
    if [[ $(dirname `pwd -P`) == $SPPATH ]]
    then
        SPGITCONFIG="$PWD/.git/config"
        if [ -f $SPGITCONFIG ]
        then
            # change origin server to the SP one
            #if ! grep -Fq "$SPGIT" $SPGITCONFIG
            #then
                #sed -i '' s#github.com:socialpoint#${SPGIT}:socialpoint# $SPGITCONFIG
                #echo "* SP-git: modified root repository origin"
            #fi

            # check for user & mail in config of the top of the repo
            if ! grep -Fq "name = $SPUSER" $SPGITCONFIG
            then
                git config user.name "$SPUSER"
                git config user.email "$SPMAIL"
                echo "* SP-git: modified root repository user & email"
            fi
        fi

        # same thing for vendors
        SPVENDORDIR="${PWD}/vendor/socialpoint"
        if [ -d $SPVENDORDIR ]
        then
            for SPVENDORDIR in `find vendor/socialpoint -type d -name .git`
            do
                SPVENDORGITCONFIG="$SPVENDORDIR/config"
                SPVENDORDIRNAME=`dirname $SPVENDORDIR`
                SPVENDORNAME=`git --git-dir=$SPVENDORDIR --work-tree=$PWD/$SPVENDORDIRNAME config --get remote.origin.url 2>/dev/null | awk -F '/' '{print $NF}' | sed 's/.git//'`
                #if ! grep -Fq "$SPGIT" $SPVENDORGITCONFIG && ! grep -Fq "x-oauth-basic" $SPVENDORGITCONFIG
                #then
                    #sed -i '' s#github.com:socialpoint#${SPGIT}:socialpoint# $SPVENDORGITCONFIG
                    #echo "* SP-git: modified vendor $SPVENDORNAME repository origin"
                #fi

                # check for user & mail in the top of the repo
                if ! grep -Fq "name = $SPUSER" $SPVENDORGITCONFIG
                then
                    git --git-dir=$SPVENDORDIR --work-tree=$PWD/$SPVENDORDIRNAME config user.name "$SPUSER"
                    git --git-dir=$SPVENDORDIR --work-tree=$PWD/$SPVENDORDIRNAME config user.email "$SPMAIL"
                    echo "* SP-git: modified vendor $SPVENDORNAME repository user & email"
                fi
            done
        fi
    fi
}

# JH

export _j="/Users/gonzalo/www/jh"
alias _j="cd $_j"

export _js="/Users/gonzalo/www/jh/src/SP"
alias _js="cd $_js"

export _jc="/Users/gonzalo/www/jh/app/config"
alias _jc="cd $_jc"

export _jv="/Users/gonzalo/www/jh/vendor/socialpoint"
alias _jv="cd $_jv"

export _bc="/Users/gonzalo/www/jh/vendor/socialpoint/backend-core/"
alias _bc="cd $_bc"

export _bcc="/Users/gonzalo/www/jh/vendor/socialpoint/backend-core/src/Component/"
alias _bcc="cd $_bcc"

export _bcg="/Users/gonzalo/www/jh/vendor/socialpoint/backend-core/src/Game/"
alias _bcg="cd $_bcg"

export _bcb="/Users/gonzalo/www/jh/vendor/socialpoint/backend-core/../backend-core-bundles/src/SP/Core/Bundle/"
alias _bcb="cd $_bcb"

export _bcb_="/Users/gonzalo/www/jh/vendor/socialpoint/backend-core/../backend-core-bundles"
alias _bcb_="cd $_bcb_"

# JH2

export _j2="/Users/gonzalo/www/jh2/"
alias _j2="cd $_j2"

export _jv2="/Users/gonzalo/www/jh2/vendor/socialpoint"
alias _jv2="cd $_jv2"

export _bc2="/Users/gonzalo/www/jh2/vendor/socialpoint/backend-core/"
alias _bc2="cd $_bc2_"

export _bcc2="/Users/gonzalo/www/jh2/vendor/socialpoint/backend-core/src/Component/"
alias _bcc2="cd $_bcc2"

export _bcg2="/Users/gonzalo/www/jh2/vendor/socialpoint/backend-core/src/Game/"
alias _bcg2="cd $_bcg2"


export _bcb2="/Users/gonzalo/www/jh2/vendor/socialpoint/backend-core/../backend-core-bundles/src/SP/Core/Bundle/"
alias _bcb2="cd $_bcb2"

export _bcb2_="/Users/gonzalo/www/jh2/vendor/socialpoint/backend-core/../backend-core-bundles"
alias _bcb2_="cd $_bcb2_"
