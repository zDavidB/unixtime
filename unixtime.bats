#!/usr/bin/env bats

TEST_BREW_PREFIX="$(brew --prefix)"
load "${TEST_BREW_PREFIX}/lib/bats-support/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-assert/load.bash"

function setup() {
    export REQUEST_DATE=''
    export REQUEST_TIME=''
}

#function teardown() {
#    echo "# teardown" >&3
#}


main0() {
    
    bash "${BATS_TEST_DIRNAME}"/unixtime.sh

}

main1() {

    bash "${BATS_TEST_DIRNAME}"/unixtime.sh ${REQUEST_DATE}

}

main1a() {

    bash "${BATS_TEST_DIRNAME}"/unixtime.sh -0 ${REQUEST_TIME}

}

main2() {
    
    bash "${BATS_TEST_DIRNAME}"/unixtime.sh ${REQUEST_DATE} ${REQUEST_TIME}        

}

@test "Script Info and Init" {
    echo "# Executing ${BATS_TEST_FILENAME}" >&3
}

@test "Call to script with no args, completes ok" {
    run main0
    assert_success

    #echo "# ${output}" >&3

    IFS=' ' 
    read -ra VALUES <<<"${output}"
    #echo "# ${VALUES[0]}" >&3
    #echo "# ${VALUES[1]}" >&3
    #echo "# ${VALUES[2]}" >&3
}

@test "Call to script with no args, returns current date" {
    CURRENT_DATE=$(date "+%d-%m-%Y")
    
    run main0
    IFS=' ' 
    read -ra VALUES <<<"${output}"
    assert_equal "${VALUES[0]}" "${CURRENT_DATE}"

}


@test "Call to script with specific date, returns that date" {
    REQUEST_DATE="2019-12-25"
    RETURN_DATE="25-12-2019"
    
    run main1
    
    IFS=' ' 
    read -ra VALUES <<<"${output}"
    assert_equal "${VALUES[0]}" "${RETURN_DATE}"
    
    #echo "# ${VALUES[0]}" >&3
    #echo "# ${VALUES[1]}" >&3
    #echo "# ${VALUES[2]}" >&3
}

@test "Call to script with specific time, returns that time and current date" {
    
    REQUEST_DATE=$(date "+%d-%m-%Y")
    REQUEST_TIME="14:25:55"
    RETURN_DATE=$(date "+%d-%m-%Y")
    RETURN_TIME="14:25:55"    

    run main1a
    
    IFS=' ' 
    read -ra VALUES <<<"${output}"
    assert_equal "${VALUES[0]}" "${RETURN_DATE}"
    assert_equal "${VALUES[1]}" "${RETURN_TIME}"

}

@test "Call to script with specific date and time, returns that date and time" {
    REQUEST_DATE="2019-12-25"
    REQUEST_TIME="13:05:15"
    RETURN_DATE="25-12-2019"
    RETURN_TIME="13:05:15"
    
    run main2
    
    IFS=' ' 
    read -ra VALUES <<<"${output}"
    assert_equal "${VALUES[0]}" "${RETURN_DATE}"
    assert_equal "${VALUES[1]}" "${RETURN_TIME}"

}