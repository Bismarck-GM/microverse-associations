document.addEventListener('DOMContentLoaded', () => {
    const closableWindows = document.querySelectorAll(".close-window");
    console.log(closableWindows);

    closableWindows.forEach((win) => {
        win.addEventListener("click", function () {
            let parent = this;
            while (!parent.classList.contains("window-outer"))
                parent = parent.parentNode
            parent.remove();
        });
    });
});
