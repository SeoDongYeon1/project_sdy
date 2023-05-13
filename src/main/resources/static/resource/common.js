const filterButton = document.querySelector('.jsFilter');
const filterMenu = document.querySelector('.filter-menu');

if (filterButton && filterMenu) {
  filterButton.addEventListener('click', function () {
    filterMenu.classList.toggle('active');
  });
}

const gridButton = document.querySelector('.grid');
const listButton = document.querySelector('.list');
const productsWrapper = document.querySelector('.products-area-wrapper');

if (gridButton && listButton && productsWrapper) {
  listButton.addEventListener('click', function () {
    listButton.classList.add('active');
    gridButton.classList.remove('active');
    productsWrapper.classList.remove('gridView');
    productsWrapper.classList.add('tableView');
  });
}

var modeSwitch = document.querySelector('.mode-switch');

modeSwitch.addEventListener('click', function() {
  if (document.documentElement.classList.contains('light')) {
    // 라이트 모드를 사용하는 경우, 다크 모드로 전환
    document.documentElement.classList.remove('light');
    localStorage.setItem('mode', 'dark'); // 로컬 스토리지에 선택한 모드 저장
  } else {
    // 다크 모드를 사용하는 경우, 라이트 모드로 전환
    document.documentElement.classList.add('light');
    localStorage.setItem('mode', 'light'); // 로컬 스토리지에 선택한 모드 저장
  }
  modeSwitch.classList.toggle('active'); // 토글 스위치 업데이트
});

// 페이지 로드 시, 이전에 선택한 모드가 로컬 스토리지에서 사용 가능한 경우 해당 모드로 전환
var savedMode = localStorage.getItem('mode');
if (savedMode) {
  document.documentElement.classList.add(savedMode);
  if (savedMode === 'light') {
    modeSwitch.classList.add('active');
  }
}

// 페이지가 로드될 때 실행
window.addEventListener('load', () => {
  // 로컬 스토리지에서 테마 값을 읽어옴
  const theme = localStorage.getItem('theme');
  
  // 테마 값이 있으면 해당 값을 변수에 할당
  if (theme) {
    document.documentElement.setAttribute('data-theme', theme);
  }
});


// board-list a태그 링크로 이동되도록
const boardLinks = document.querySelectorAll('.board-list a');

boardLinks.forEach(link => {
  link.addEventListener('click', function(event) {
    event.preventDefault(); // 기본 동작 막기
    window.location.href = link.getAttribute('href'); // 링크 주소로 이동
  });
});



const sidebarList = document.querySelectorAll('.sidebar-list-item');
const activeClass = 'active';

sidebarList.forEach(item => {
  item.addEventListener('click', () => {
    sidebarList.forEach(sibling => sibling.classList.remove(activeClass));
    item.classList.add(activeClass);
  });

  const currentPath = window.location.pathname;
  const itemPath = item.querySelector('a').getAttribute('href');
  
  if (currentPath === itemPath) {
    sidebarList.forEach(sibling => sibling.classList.remove(activeClass));
    item.classList.add(activeClass);
  }
});
