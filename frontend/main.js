window.addEventListener('DOMContentLoaded', (event) =>{
    getVisitCount();
})

const functionApi = 'https://pdafuncapp.azurewebsites.net/api/HttpTrigger1?code=9hOKEFd4QK82Gwk3vscWqnA0t72pDxxDqZJToEDE5NuHAzFu0Kzh8A==';

const getVisitCount = () => {
    let count = 30;
    fetch(functionApi).then(response => {
        return response.json()
    }).then(response =>{
        console.log("Website called function from API.")
        count = response.vCount;
        document.getElementById("counter").innerText = count;
    }).catch(function(error){
        console.log(error);
    });
    return count;
}