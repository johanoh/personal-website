document.addEventListener("DOMContentLoaded", () => {
    const toggleButton = document.getElementById("theme-toggle");

    if (toggleButton) {
        const savedTheme = localStorage.getItem("theme");

        if (savedTheme) {
            document.documentElement.setAttribute("data-theme", savedTheme);
        } else if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
            document.documentElement.setAttribute("data-theme", "dark");
        }

        toggleButton.addEventListener("click", () => {
            const currentTheme = document.documentElement.getAttribute("data-theme");
            const newTheme = currentTheme === "dark" ? "light" : "dark";

            document.documentElement.setAttribute("data-theme", newTheme);
            localStorage.setItem("theme", newTheme);
        });
    }
});
