function limitText(limitField) {
	limitNum = 500;
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    } 
}
