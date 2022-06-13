import generateRandomId from './generateRandomId'

function getDateString(dateParam){
    const newDate = new Date(dateParam)
    const year = newDate.getFullYear()
    let month = newDate.getMonth() + 1
    let date = newDate.getDate()

    Number(month) < 10 ? month = '0'+month : null
    Number(date) < 10 ? date = '0'+date: null

    return `${year}-${month}-${date}`
}


export {
    getDateString,
    generateRandomId
}