function formatMoney(n) {
    return "$" + (Number(n) || 0).toLocaleString();
}

function showHUD(visible) {
    const hud = document.getElementById('hud-container');
    if (!hud) return;
    hud.style.display = visible ? 'flex' : 'none';
}

function setLogoPulse(enable) {
    const logo = document.getElementById('server-logo');
    if (!logo) return;
    if (enable) logo.classList.add('glow'); else logo.classList.remove('glow');
}

window.addEventListener('message', function(event) {
    const item = event.data;
    if (!item) return;

    if (item.action === "toggle") {
        showHUD(item.show);
    }

    if (item.action === "update") {
        const sid   = document.getElementById('sid');
        const cid   = document.getElementById('cid');
        const cash  = document.getElementById('cash');
        const bank  = document.getElementById('bank');
        const job   = document.getElementById('job');
        const grade = document.getElementById('grade');

        if (sid)   sid.textContent   = item.sid ?? sid.textContent;
        if (cid)   cid.textContent   = item.cid ?? cid.textContent;
        if (cash)  cash.textContent  = formatMoney(item.cash);
        if (bank)  bank.textContent  = formatMoney(item.bank);
        if (job)   job.textContent   = item.job ?? job.textContent;
        if (grade) {
            if (item.grade && item.grade !== "") {
                grade.textContent = item.grade;
                grade.style.display = 'inline-block';
            } else {
                grade.style.display = 'none';
            }
        }

        setLogoPulse(true);
        setTimeout(()=> setLogoPulse(false), 900);
    }
});