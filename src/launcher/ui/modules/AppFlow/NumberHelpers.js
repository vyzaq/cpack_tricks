.pragma library

function validateDoubleString(localizedDecimalPoints, text) {
    var validatorPattern = new RegExp("^[+-]?([0-9]*[.%1])?[0-9]+$".arg(localizedDecimalPoints), 'i');
    return validatorPattern.test(text)
}

function validateLatitudeString(localizedDecimalPoints, text) {
    if(!validateDoubleString(localizedDecimalPoints, text))
        return false
    var replacePattern = new RegExp("[%1]".arg(localizedDecimalPoints), 'i');
    var parsedValue = parseFloat(text.replace(replacePattern, '.'))
    return parsedValue < 90 && parsedValue > -90
}

function validateLongitudeString(localizedDecimalPoints, text) {
    if(!validateDoubleString(localizedDecimalPoints, text))
        return false
    var replacePattern = new RegExp("[%1]".arg(localizedDecimalPoints), 'i');
    var parsedValue = parseFloat(text.replace(replacePattern, '.'))
    return parsedValue < 180 && parsedValue > -180
}

function convertStringToDouble(localizedDecimalPoints, text) {
    var replacePattern = new RegExp("[%1]".arg(localizedDecimalPoints), 'i');
    return parseFloat(text.replace(replacePattern, '.'))
}
