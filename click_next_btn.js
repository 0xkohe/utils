(async () => {
  let count = 0;
  const maxClicks = 30;

  while (count < maxClicks) {
    // 「続きを表示」ボタンを探す
    const button = document.querySelector('button, a, div')
      && Array.from(document.querySelectorAll('button, a, div'))
        .find(el => el.innerText.trim() === "続きを表示");

    if (button) {
      button.click();
      count++;
      console.log(`続きを表示をクリックしました (${count}/${maxClicks})`);
      // 次にボタンが出るまで少し待つ（調整可）
      await new Promise(r => setTimeout(r, 2000));
    } else {
      // ボタンがまだ出てない場合、少し待って再確認
      await new Promise(r => setTimeout(r, 1000));
    }
  }

  console.log("30回クリック完了しました。");
})();
